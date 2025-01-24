using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class GameController : MonoBehaviour
{
    private static readonly object ? _lock = new object();
    private static GameController _instance;
    private static bool applicationIsQuitting = false;

    public static GameController Instance => _instance;

    public GameManager gameManager = GameManager.Idle;
    private List<IGameStateController> gameStateControllers = new List<IGameStateController>();
    public PlayerController playerController = null;
    public int gamevolume;
    public int musicvolume;
    public int highscore = 0;
    public int currentScore = 0;

    [Header("Game Progress")]
    public int currentLevel { get; private set; } = 0;
    private const int MAX_LEVEL = 2;
    private readonly int[] LEVEL_THRESHOLDS = new int[] { 1000, 2500 };

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
        InitializeControllers();
        LoadPrefs();
        currentLevel = 0;
        UIManager.Instance.UpdateScoreDisplay(currentScore, highscore);
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

    public void AddScore(int points)
    {
        currentScore += points;
        CheckLevelProgression();
        if (currentScore > highscore)
        {
            highscore = currentScore;
        }
        UIManager.Instance.UpdateScoreDisplay(currentScore, highscore);
    }

    private void CheckLevelProgression()
    {
        if (currentLevel >= MAX_LEVEL) return;

        for (int i = 0; i < LEVEL_THRESHOLDS.Length; i++)
        {
            if (currentScore >= LEVEL_THRESHOLDS[i] && currentLevel < i + 1)
            {
                currentLevel = Mathf.Min(i + 1, MAX_LEVEL);
                Debug.Log($"Level Up! Now at level {currentLevel}");
            }
        }
    }

    public void UpdateHighScore(int newHighScore)
    {
        highscore = newHighScore;
        SavePrefs();
    }

    public void SavePrefs()
    {
        PlayerPrefs.SetInt("GameVolume", gamevolume);
        PlayerPrefs.SetInt("MusicVolume", musicvolume);
        PlayerPrefs.SetInt("HighScore", highscore);
        PlayerPrefs.SetInt("CurrentLevel", currentLevel);
        PlayerPrefs.Save();
    }

    public void LoadPrefs()
    {
        gamevolume = PlayerPrefs.GetInt("GameVolume", gamevolume);
        musicvolume = PlayerPrefs.GetInt("MusicVolume", musicvolume);
        highscore = PlayerPrefs.GetInt("HighScore", 0);
        currentLevel = PlayerPrefs.GetInt("CurrentLevel", 0);
    }

    private void OnDestroy()
    {
        if (_instance == this)
        {
            applicationIsQuitting = true;
            SavePrefs();
        }
    }

    private void OnApplicationQuit()
    {
        applicationIsQuitting = true;
        SavePrefs();
    }

    private void InitializeControllers()
    {
        gameStateControllers.Clear();
        var rootObjects = UnityEngine.SceneManagement.SceneManager.GetActiveScene().GetRootGameObjects();
        
        foreach (var root in rootObjects)
        {
            gameStateControllers.AddRange(root.GetComponentsInChildren<MonoBehaviour>().OfType<IGameStateController>());
        }
    }

    public void ResetGame()
    {
        currentScore = 0;
        currentLevel = 0;
        ScoreManager.Instance?.ResetScore();
        UIManager.Instance?.UpdateScoreDisplay(currentScore, highscore);
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
        currentScore = newScore;
        CheckLevelProgression();
    }

    private void OnScoreChanged(int newScore)
    {
        currentScore = newScore;
        CheckLevelProgression();
    }
}
