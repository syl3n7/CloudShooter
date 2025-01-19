using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class GameController : MonoBehaviour
{
    public static GameController instance;
    public GameManager gameManager = GameManager.Idle;
    private List<IGameStateController> gameStateControllers = new List<IGameStateController>();
    public PlayerController playerController = null;
    public int gamevolume;
    public int musicvolume;
    public int highscore = 0;

    private void Awake()
    {
        instance = this;
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

    private void OnApplicationQuit()
    {
        SavePrefs();
    }
}
