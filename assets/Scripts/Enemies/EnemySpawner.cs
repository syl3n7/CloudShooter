using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class EnemySpawner : MonoBehaviour
{
    public GameObject[] enemyPrefabs; // Array of enemy prefabs (Normal, Fast, Tough)
    public float spawnInterval = 2f; // Time between spawns
    public int waveSize = 10; // Number of enemies per wave
    public float waveCooldown = 5f; // Time between waves

    private int currentWave = 0;

    private void Start()
    {
        enemyPrefabs = new GameObject[3];
        
        // Load prefabs with error checking
        enemyPrefabs[0] = Resources.Load<GameObject>("Prefabs/Enemy");
        enemyPrefabs[1] = Resources.Load<GameObject>("Prefabs/EnemyFast");
        enemyPrefabs[2] = Resources.Load<GameObject>("Prefabs/EnemyTough");  // Fixed typo

        // Verify all prefabs loaded correctly
        for (int i = 0; i < enemyPrefabs.Length; i++)
        {
            if (enemyPrefabs[i] == null)
            {
                Debug.LogError($"Failed to load enemy prefab at index {i}");
                return; // Don't start coroutine if prefabs are missing
            }
        }

        // Only start spawning if all prefabs loaded successfully
        StartCoroutine(SpawnWaves());
    }

    IEnumerator SpawnWaves()
    {
        while (true) // Infinite waves
        {
            currentWave++;
            Debug.Log("Starting Wave " + currentWave);

            for (int i = 0; i < waveSize; i++)
            {
                SpawnEnemy();
                yield return new WaitForSeconds(spawnInterval);
            }

            yield return new WaitForSeconds(waveCooldown); // Wait before next wave
        }
    }

    void SpawnEnemy()
    {
        // Randomly select an enemy type based on wave progression
        int enemyIndex = GetEnemyTypeForWave(currentWave);
        GameObject enemy = Instantiate(enemyPrefabs[enemyIndex], GetSpawnPosition(), Quaternion.identity);
    }

    int GetEnemyTypeForWave(int wave)
    {
        // Adjust logic to control enemy types per wave
        if (wave % 5 == 0) // Every 5th wave, spawn tougher enemies
        {
            return 2; // Tough enemy
        }
        else if (wave % 2 == 0) // Every even wave, spawn faster enemies
        {
            return 1; // Fast enemy
        }
        else
        {
            return 0; // Normal enemy
        }
    }

    Vector3 GetSpawnPosition()
    {
        // Spawn enemies off-screen to the right
        float spawnY = Random.Range(-4f, 4f); // Random Y position within screen bounds
        return new Vector3(10f, spawnY, 0f); // Adjust X for off-screen spawning
    }
}