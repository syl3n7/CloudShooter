using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScoreManager : MonoBehaviour
{
    private static ScoreManager _instance;
    public static ScoreManager Instance => _instance;
    
    private int currentScore;
    private int highScore;

    public delegate void ScoreChangedHandler(int newScore);
    public event ScoreChangedHandler OnScoreChanged;
    
    private void Awake()
    {
        if (_instance == null)
        {
            _instance = this;
            DontDestroyOnLoad(gameObject);
            LoadScores();
        }
        else
        {
            Destroy(gameObject);
        }
    }

    private void OnEnable()
    {
        if (GameController.Instance != null)
        {
            // Initialize score from GameController if needed
            currentScore = GameController.Instance.currentScore;
            highScore = GameController.Instance.highscore;
        }
    }

    public int GetCurrentScore() => currentScore;
    public int GetHighScore() => highScore;

    public void InvokeScoreChanged()
    {
        OnScoreChanged?.Invoke(currentScore);
    }

    public void AddScore(int points)
    {
        currentScore += points;
        InvokeScoreChanged();
        if (currentScore > highScore)
        {
            highScore = currentScore;
            GameController.Instance.UpdateHighScore(highScore);
        }
        UIManager.Instance.UpdateScoreDisplay(currentScore, highScore);
        SaveScores();
    }

    public void ResetScore()
    {
        currentScore = 0;
        OnScoreChanged?.Invoke(currentScore);
        UIManager.Instance?.UpdateScoreDisplay(currentScore, highScore);
        SaveScores();
    }

    private void SaveScores()
    {
        PlayerPrefs.SetInt("CurrentScore", currentScore);
        PlayerPrefs.SetInt("HighScore", highScore);
        PlayerPrefs.Save();
    }

    private void LoadScores()
    {
        currentScore = PlayerPrefs.GetInt("CurrentScore", 0);
        highScore = PlayerPrefs.GetInt("HighScore", 0);
    }

    private void OnDestroy()
    {
        if (_instance == this)
        {
            SaveScores();
        }
    }
}
