using UnityEngine;
using System.Collections;

public class EnemySpawner : MonoBehaviour
{
    private GameObject[] enemyPrefabs;
    public float spawnInterval = 2f;
    private Camera mainCamera;
    
    [Header("Level Settings")]
    private int currentLevel = 0;
    [SerializeField] private int[] levelThresholds = new int[] { 1000, 2500 }; // Score needed for level up

    void Start()
    {
        mainCamera = Camera.main;
        
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

        StartCoroutine(SpawnRoutine());
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

    IEnumerator SpawnRoutine()
    {
        while (true)
        {
            SpawnEnemy();
            yield return new WaitForSeconds(spawnInterval);
        }
    }

    void SpawnEnemy()
    {
        if (enemyPrefabs == null || enemyPrefabs.Length == 0)
        {
            Debug.LogError("No enemy prefabs available!");
            return;
        }

        Vector3 rightEdge = mainCamera.ViewportToWorldPoint(new Vector3(1.1f, 0f, 0f));
        
        float randomY = Random.Range(
            mainCamera.ViewportToWorldPoint(new Vector3(0, 0.1f, 0)).y,
            mainCamera.ViewportToWorldPoint(new Vector3(0, 0.9f, 0)).y
        );

        Vector3 spawnPosition = new Vector3(rightEdge.x, randomY, 0f);
        
        // Ensure we don't exceed array bounds
        GameObject selectedPrefab = enemyPrefabs[currentLevel];
        Instantiate(selectedPrefab, spawnPosition, Quaternion.identity);
    }

    private void OnDestroy()
    {
        // Unsubscribe from score changes
        if (ScoreManager.Instance != null)
        {
            ScoreManager.Instance.OnScoreChanged -= CheckLevelUp;
        }
    }
}