using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScoreManager : MonoBehaviour
{
    private static ScoreManager _instance;
    public static ScoreManager Instance => _instance;
    
    private int currentScore;
    private int highScore;
    
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

    public int GetCurrentScore() => currentScore;
    public int GetHighScore() => highScore;

    public void AddScore(int points)
    {
        currentScore += points;
        if (currentScore > highScore)
        {
            highScore = currentScore;
            GameController.Instance.UpdateHighScore(highScore);
        }
        UIManager.Instance.UpdateScoreDisplay(currentScore, highScore);
    }

    public void ResetScore()
    {
        currentScore = 0;
        UIManager.Instance.UpdateScoreDisplay(currentScore, highScore);
    }
}
