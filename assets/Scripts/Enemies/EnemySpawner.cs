using UnityEngine;
using System.Collections;

public class EnemySpawner : MonoBehaviour, IGameStateController
{
    private GameObject[] enemyPrefabs;
    public float spawnInterval = 2f;
    private Camera mainCamera;
    private bool isSpawning = false;
    
    [Header("Level Settings")]
    private int currentLevel = 0;
    [SerializeField] private int[] levelThresholds = new int[] { 1000, 2500 }; // Score needed for level up

    void Start()
    {
        mainCamera = Camera.main;
        LoadEnemyPrefabs();
    }

    private void LoadEnemyPrefabs()
    {
        // Initialize and load prefabs
        enemyPrefabs = new GameObject[3];
        string[] prefabPaths = new string[] {
            "Prefabs/Enemy/Enemy",     // Level 0: Normal enemy
            "Prefabs/Enemy/EnemyFast", // Level 1: Fast enemy
            "Prefabs/Enemy/EnemyTough" // Level 2: Tough enemy
        };
        
        // Load all prefabs
        for (int i = 0; i < enemyPrefabs.Length; i++)
        {
            enemyPrefabs[i] = Resources.Load<GameObject>(prefabPaths[i]);
            if (enemyPrefabs[i] == null)
            {
                Debug.LogError($"Failed to load enemy prefab at path: {prefabPaths[i]}");
                return;
            }
        }

        // Subscribe to score changes
        if (ScoreManager.Instance != null)
        {
            ScoreManager.Instance.OnScoreChanged += CheckLevelUp;
        }
        else
        {
            Debug.LogError("ScoreManager instance is not initialized.");
        }
    }

    private void OnEnable()
    {
        if (ScoreManager.Instance != null)
        {
            ScoreManager.Instance.OnScoreChanged += HandleScoreChanged;
        }
    }

    private void OnDisable()
    {
        if (ScoreManager.Instance != null)
        {
            ScoreManager.Instance.OnScoreChanged -= HandleScoreChanged;
        }
    }

    private void HandleScoreChanged(int newScore)
    {
        CheckLevelUp(newScore);
    }

    private void CheckLevelUp(int newScore)
    {
        int maxLevel = 2; // Maximum level (0,1,2 = 3 levels total)
        
        if (currentLevel >= maxLevel)
        {
            return; // Already at max level
        }

        for (int i = 0; i < levelThresholds.Length; i++)
        {
            if (newScore >= levelThresholds[i] && currentLevel < Mathf.Min(i + 1, maxLevel))
            {
                currentLevel = Mathf.Min(i + 1, maxLevel);
                Debug.Log($"Level Up! Now at level {currentLevel} (Max Level: {maxLevel})");
                
                if (currentLevel == maxLevel)
                {
                    Debug.Log("Maximum level reached!");
                }
            }
        }
    }

    private IEnumerator SpawnRoutine()
    {
        isSpawning = true;
        while (isSpawning)
        {
            if (GameController.Instance.gameManager == GameManager.Playing)
            {
                SpawnEnemy();
            }
            yield return new WaitForSeconds(spawnInterval);
        }
    }

    private void SpawnEnemy()
    {
        if (enemyPrefabs == null || enemyPrefabs.Length == 0) return;

        Vector3 rightEdge = mainCamera.ViewportToWorldPoint(new Vector3(1.1f, 0f, 0f));
        float randomY = Random.Range(
            mainCamera.ViewportToWorldPoint(new Vector3(0, 0.1f, 0)).y,
            mainCamera.ViewportToWorldPoint(new Vector3(0, 0.9f, 0)).y
        );

        Vector3 spawnPosition = new Vector3(rightEdge.x, randomY, 0f);
        GameObject selectedPrefab = enemyPrefabs[Mathf.Min(currentLevel, enemyPrefabs.Length - 1)];
        Instantiate(selectedPrefab, spawnPosition, Quaternion.identity, transform.parent);
    }

    private void OnDestroy()
    {
        isSpawning = false;
        // Unsubscribe from score changes
        if (ScoreManager.Instance != null)
        {
            ScoreManager.Instance.OnScoreChanged -= CheckLevelUp;
        }
    }

    public void Idle() 
    {
        isSpawning = false;
        StopAllCoroutines();
    }
    public void Playing() 
    {
        if (!isSpawning)
        {
            StartCoroutine(SpawnRoutine());
        }
    }
    public void Paused() 
    {
        isSpawning = false;
    }
    public void Dead() 
    {
        isSpawning = false;
        StopAllCoroutines();
    }
}