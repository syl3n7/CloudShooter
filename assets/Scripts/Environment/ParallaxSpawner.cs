using UnityEngine;

public class ParallaxSpawner : MonoBehaviour, IGameStateController
{
    private GameObject[] parallaxLayers;
    [SerializeField] private int instancesPerLayer = 3; // Number of instances per layer
    private Camera mainCamera;
    // Increased speeds for visible movement
    private float[] layerSpeeds = { 5f, 3f, 1f }; // Foreground fastest, Background slowest
    private string[] layerPaths = {
        "Prefabs/Paralax/Foreground",
        "Prefabs/Paralax/Middleground",
        "Prefabs/Paralax/Background"
    };
    private bool isInitialized = false;

    void Start()
    {
        mainCamera = Camera.main;
        LoadParallaxLayers();
    }

    private void LoadParallaxLayers()
    {
        parallaxLayers = new GameObject[layerPaths.Length];
        for (int i = 0; i < layerPaths.Length; i++)
        {
            parallaxLayers[i] = Resources.Load<GameObject>(layerPaths[i]);
            if (parallaxLayers[i] == null)
            {
                Debug.LogError($"Failed to load parallax layer at path: {layerPaths[i]}");
            }
        }
    }

    private void SpawnParallaxLayers()
    {
        for (int i = 0; i < parallaxLayers.Length; i++)
        {
            float layerHeight = parallaxLayers[i].GetComponent<SpriteRenderer>().bounds.size.y;
            float layerWidth = parallaxLayers[i].GetComponent<SpriteRenderer>().bounds.size.x;
            float bottomY = mainCamera.ViewportToWorldPoint(new Vector3(0, 0, 0)).y + layerHeight / 2;

            // Position instances consecutively: current, next, after
            for (int j = 0; j < instancesPerLayer; j++)
            {
                float xOffset = j * layerWidth; // Each instance starts where previous ends
                Vector3 spawnPosition = new Vector3(xOffset, bottomY, parallaxLayers[i].transform.position.z);
                GameObject layerInstance = Instantiate(parallaxLayers[i], spawnPosition, Quaternion.identity);
                layerInstance.transform.SetParent(transform);
                layerInstance.GetComponent<Parallax>().Initialize(layerSpeeds[i]);
            }
        }
    }

    public void Idle()
    {
        foreach (Transform child in transform)
        {
            Destroy(child.gameObject);
        }
        isInitialized = false;
    }

    public void Playing()
    {
        if (!isInitialized)
        {
            SpawnParallaxLayers();
            isInitialized = true;
        }
    }

    public void Paused() { }

    public void Dead()
    {
        foreach (Transform child in transform)
        {
            Destroy(child.gameObject);
        }
        isInitialized = false;
    }
}