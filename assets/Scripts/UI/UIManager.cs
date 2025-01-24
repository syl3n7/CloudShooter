using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour 
{
    private static UIManager _instance;
    public static UIManager Instance => _instance;

    [Header("Score UI")]
    [SerializeField] private Text currentScoreText;
    [SerializeField] private Text highScoreText;

    [SerializeField] private Button start_bttn;
    [SerializeField] private Button exit_bttn;
    [SerializeField] private Button instructions_bttn;
    [SerializeField] private Button highscore_bttn;
    [SerializeField] private GameObject main_menu_panel;
    [SerializeField] private GameObject instructions_panel;
    [SerializeField] private GameObject highscore_panel;
    [SerializeField] private GameObject InGame_panel;

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
            //carregar highscore antes de comecar o jogo
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
    }
    void start_game()
    {
        main_menu_panel.SetActive(false);
        InGame_panel.SetActive(true);
    }

    //bg.GetComponent<Image>().sprite = Spritexpto

    //jogar

    public void Quit()
    {
        
    }

    //instrucoes

    //pontuacoes

    public void UpdateScoreDisplay(int currentScore, int highScore)
    {
        if (currentScoreText != null)
            currentScoreText.text = $"Score: {currentScore}";
        if (highScoreText != null)
            highScoreText.text = $"High Score: {highScore}";
    }
}
