using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScoreManager
{
    private int score;
    public ScoreManager(int score)
    {
        this.score = score;
    }

    public int GetScore()
    {
        return score;
    }

    public void SetScore(int score)
    {
        this.score = score;
    }

    public void AddScore(int score)
    {
        this.score += score;
    }
    public void RemoveScore(int score)
    {
        this.score -= score;
    }
}
