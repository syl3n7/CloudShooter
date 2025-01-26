using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    private static UIManager _instance;
    public static UIManager Instance => _instance;

    [Header("Score UI")]
    [SerializeField] private TMPro.TMP_Text currentScoreText;
    [SerializeField] private TMPro.TMP_Text highScoreText;

    [Header("Player UI")]
    [SerializeField] private HealthBar playerHealthBar;

    [SerializeField] private Button start_bttn;
    [SerializeField] private Button exit_bttn;
    [SerializeField] private Button instructions_bttn;
    [SerializeField] private Button highscore_bttn;
    [SerializeField] private Button backI_bttn;
    [SerializeField] private Button backH_bttn;
    [SerializeField] private GameObject main_menu_panel;
    [SerializeField] private GameObject instructions_panel;
    [SerializeField] private GameObject highscore_panel;
    [SerializeField] private GameObject InGame_panel;
    [SerializeField] private GameObject pause_menu_panel;
    [SerializeField] private Button resume_bttn;
    [SerializeField] private Button quit_to_menu_bttn;

    [Header("Lives Display")]
    [SerializeField] private Image[] lifeHearts;

    private void Awake()
    {
        if (_instance == null)
        {
            _instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }

    void Start()
    {
        start_bttn.onClick.AddListener(delegate
        {
            start_game();
        });

        exit_bttn.onClick.AddListener(delegate
        {
            GameController.Instance.SavePrefs();
            Application.Quit();
        });

        instructions_bttn.onClick.AddListener(delegate
        {
            main_menu_panel.SetActive(false);
            instructions_panel.SetActive(true);
        });

        highscore_bttn.onClick.AddListener(delegate
        {
            main_menu_panel.SetActive(false);
            highscore_panel.SetActive(true);
        });

        backI_bttn.onClick.AddListener(delegate
        {
            instructions_panel.SetActive(false);
            main_menu_panel.SetActive(true);
        });

        backH_bttn.onClick.AddListener(delegate
        {
            highscore_panel.SetActive(false);
            main_menu_panel.SetActive(true);
        });

        resume_bttn.onClick.AddListener(delegate
        {
            ResumeGame();
        });

        quit_to_menu_bttn.onClick.AddListener(delegate
        {
            QuitToMenu();
        });

        UpdateLivesDisplay(3); // Initialize with max lives
    }
    void start_game()
    {
        main_menu_panel.SetActive(false);
        GameController.Instance.ChangeState(GameManager.Playing);
        InGame_panel.SetActive(true);
    }

    public void UpdateScoreDisplay(int currentScore, int highScore)
    {
        if (currentScoreText != null)
            currentScoreText.text = $"Score: {currentScore}";
        if (highScoreText != null)
            highScoreText.text = $"High Score: {highScore}";
    }

    public void UpdateLivesDisplay(int currentLives)
    {
        for (int i = 0; i < lifeHearts.Length; i++)
        {
            if (lifeHearts[i] != null)
            {
                lifeHearts[i].enabled = i < currentLives;
            }
        }
    }

    public void PauseGame()
    {
        Time.timeScale = 0;
        pause_menu_panel.SetActive(true);
        GameController.Instance.ChangeState(GameManager.Paused);
    }

    public void ResumeGame()
    {
        Time.timeScale = 1;
        pause_menu_panel.SetActive(false);
        GameController.Instance.ChangeState(GameManager.Playing);
    }

    private void QuitToMenu()
    {
        Time.timeScale = 1;
        pause_menu_panel.SetActive(false);
        main_menu_panel.SetActive(true);
        InGame_panel.SetActive(false);
        GameController.Instance.ChangeState(GameManager.Idle);
        GameController.Instance.ResetGame();
    }
}
