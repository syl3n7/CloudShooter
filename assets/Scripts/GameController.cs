using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class GameController : MonoBehaviour
{
    public static GameController instance;
    public GameManager gameManager = GameManager.Idle;
    private List<IGameStateController> gameStateControllers = new List<IGameStateController>();

    private void Awake()
    {
        instance = this;
    }

    private void Start()
    {
        gameStateControllers.AddRange(FindObjectsOfType<MonoBehaviour>().OfType<IGameStateController>());
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
}
