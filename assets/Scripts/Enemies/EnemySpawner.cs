using UnityEngine;
using System.Collections;

public class EnemySpawner : MonoBehaviour
{
    public GameObject enemyPrefab;
    public float spawnInterval = 2f;
    private Camera mainCamera;

    void Start()
    {
        mainCamera = Camera.main;
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
        Vector3 rightEdge = mainCamera.ViewportToWorldPoint(new Vector3(1.1f, 0f, 0f));
        
        float randomY = Random.Range(
            mainCamera.ViewportToWorldPoint(new Vector3(0, 0.1f, 0)).y,
            mainCamera.ViewportToWorldPoint(new Vector3(0, 0.9f, 0)).y
        );

        Vector3 spawnPosition = new Vector3(rightEdge.x, randomY, 0f);
        Instantiate(enemyPrefab, spawnPosition, Quaternion.identity);
    }
}