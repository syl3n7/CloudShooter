using UnityEngine;
using System.Collections;

public class CloudSpawner : MonoBehaviour, IGameStateController
{
    private GameObject[] cloudPrefabs;
    [SerializeField] private float minSpawnTime = 3f;
    [SerializeField] private float maxSpawnTime = 5f;
    [SerializeField] private float cloudSpeed = 20f; 
    private Camera mainCamera;
    private bool isSpawning = false;

    void Start()
    {
        mainCamera = Camera.main;
        LoadCloudPrefabs();
    }

    private void LoadCloudPrefabs()
    {
        cloudPrefabs = new GameObject[5];
        for (int i = 0; i < cloudPrefabs.Length; i++)
        {
            string path = $"Prefabs/Clouds/cloud{i + 1}";
            cloudPrefabs[i] = Resources.Load<GameObject>(path);
            if (cloudPrefabs[i] == null)
            {
                Debug.LogError($"Failed to load cloud prefab at path: {path}");
            }
        }
    }

    private IEnumerator SpawnClouds()
    {
        while (isSpawning)
        {
            if (GameController.Instance.gameManager == GameManager.Playing)
            {
                SpawnCloud();
            }
            yield return new WaitForSeconds(Random.Range(minSpawnTime, maxSpawnTime));
        }
    }

    private void SpawnInitialClouds()
    {
        // Get screen bounds
        float screenLeft = mainCamera.ViewportToWorldPoint(new Vector3(0.2f, 0, 0)).x;
        float screenRight = mainCamera.ViewportToWorldPoint(new Vector3(0.8f, 0, 0)).x;

        for (int i = 0; i < 5; i++)
        {
            Vector3 spawnPosition = new Vector3(
                Random.Range(screenLeft, screenRight),
                Random.Range(
                    mainCamera.ViewportToWorldPoint(new Vector3(0, 0.1f, 0)).y,
                    mainCamera.ViewportToWorldPoint(new Vector3(0, 0.9f, 0)).y
                ),
                0f
            );

            int randomCloudIndex = Random.Range(0, cloudPrefabs.Length);
            GameObject cloud = Instantiate(cloudPrefabs[randomCloudIndex], spawnPosition, Quaternion.identity);
            cloud.transform.SetParent(transform);
            
            // Set cloud sprite layer
            SpriteRenderer cloudSprite = cloud.GetComponent<SpriteRenderer>();
            cloudSprite.sortingLayerName = "Clouds";
            
            CloudMovement movement = cloud.GetComponent<CloudMovement>();
            if (movement != null)
            {
                movement.Initialize(cloudSpeed);
            }
        }
    }

    private void SpawnCloud()
    {
        Vector3 spawnPosition = GetSpawnPosition();
        int randomCloudIndex = Random.Range(0, cloudPrefabs.Length);
        GameObject cloud = Instantiate(cloudPrefabs[randomCloudIndex], spawnPosition, Quaternion.identity);
        cloud.transform.SetParent(transform);
        
        // Set cloud sprite layer
        SpriteRenderer cloudSprite = cloud.GetComponent<SpriteRenderer>();
        cloudSprite.sortingLayerName = "Clouds";
        
        CloudMovement movement = cloud.AddComponent<CloudMovement>();
        movement.Initialize(cloudSpeed);
    }

    private Vector3 GetSpawnPosition()
    {
        float rightEdge = mainCamera.ViewportToWorldPoint(new Vector3(1.1f, 0, 0)).x;
        float randomY = Random.Range(
            mainCamera.ViewportToWorldPoint(new Vector3(0, 0.1f, 0)).y,
            mainCamera.ViewportToWorldPoint(new Vector3(0, 0.9f, 0)).y
        );
        return new Vector3(rightEdge, randomY, 0);
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
            isSpawning = true;
            SpawnInitialClouds();
            StartCoroutine(SpawnClouds());
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