using UnityEngine;
using System.Collections;

public class EnemySpawner : MonoBehaviour
{
    private GameObject[] enemyPrefabs;
    public float spawnInterval = 2f;
    private Camera mainCamera;

    void Start()
    {
        mainCamera = Camera.main;
        
        // Initialize and load prefabs
        enemyPrefabs = new GameObject[3];
        string[] prefabPaths = new string[] {
            "Prefabs/Enemy/Enemy",
            "Prefabs/Enemy/EnemyFast",
            "Prefabs/Enemy/EnemyTough"
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

        StartCoroutine(SpawnRoutine());
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
        
        // Randomly select an enemy prefab
        GameObject selectedPrefab = enemyPrefabs[Random.Range(0, enemyPrefabs.Length)];
        Instantiate(selectedPrefab, spawnPosition, Quaternion.identity);
    }
}