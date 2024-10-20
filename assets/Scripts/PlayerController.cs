using System;
using UnityEngine;

public class PlayerController : MonoBehaviour, IGameStateController
{
    private ScoreManager smanager;
    private bool up, down, left, right;
    public void Dead()
    {
        GameController.instance.highscore = smanager.GetScore();
    }

    public void Idle()
    {

    }

    public void Playing()
    {
        MoveMe();
    }

    private void MoveMe()
    {

    }

    void Start()
    {
        smanager = new ScoreManager(GameController.instance.highscore);
    }
}
