using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class GameController : MonoBehaviour
{
    private static readonly object _lock = new object();
    private static GameController _instance;
    private static bool applicationIsQuitting = false;

    public static GameController Instance
    {
        get
        {
            if (applicationIsQuitting)
            {
                Debug.LogWarning("Instance of GameController already destroyed on application quit. Won't create again.");
                return null;
            }
            
            lock (_lock)
            {
                if (_instance == null)
                {
                    _instance = FindObjectOfType<GameController>();
                    
                    if (_instance == null)
                    {
                        var singleton = new GameObject(typeof(GameController).Name);
                        _instance = singleton.AddComponent<GameController>();
                        
                        Debug.Log("Created new GameController instance.");
                    }
                }
                return _instance;
            }
        }
    }

    public GameManager gameManager = GameManager.Idle;
    private List<IGameStateController> gameStateControllers = new List<IGameStateController>();
    public PlayerController playerController = null;
    public int gamevolume;
    public int musicvolume;
    public int highscore = 0;

    private void Awake()
    {
        if (_instance != null && _instance != this)
        {
            Debug.LogWarning($"Multiple GameController instances detected. Destroying duplicate on {gameObject.name}");
            Destroy(gameObject);
            return;
        }
        
        _instance = this;
        DontDestroyOnLoad(gameObject);
        InitializeController();
    }

    private void InitializeController()
    {
        // Add initialization logic here
        gameManager = GameManager.Idle;
        gameStateControllers.Clear();
    }

    private void Start()
    {
        gameStateControllers.AddRange(FindObjectsOfType<IGameStateController>());
        LoadPrefs();
    }

    private void Update()
    {
        foreach (var controller in gameStateControllers)
        {
            switch (gameManager)
            {
                case GameManager.Idle:
                    controller.Idle();
                    break;
                case GameManager.Playing:
                    controller.Playing();
                    break;
                case GameManager.Dead:
                    controller.Dead();
                    break;
            }
        }
        
    }

    public void ChangeState(GameManager gameManager)
    {
        this.gameManager = gameManager;
    }

    public void SavePrefs()
    {
        PlayerPrefs.SetInt("GameVolume", gamevolume);
        PlayerPrefs.SetInt("MusicVolume", musicvolume);
        PlayerPrefs.SetInt("HighScore", highscore);
        PlayerPrefs.Save();
    }

    public void LoadPrefs()
    {
        gamevolume = PlayerPrefs.GetInt("GameVolume", gamevolume);
        musicvolume = PlayerPrefs.GetInt("MusicVolume", musicvolume);
        highscore = PlayerPrefs.GetInt("HighScore", highscore);
    }

    private void OnDestroy()
    {
        if (_instance == this)
        {
            applicationIsQuitting = true;
        }
    }

    private void OnApplicationQuit()
    {
        applicationIsQuitting = true;
        SavePrefs();
    }
}
