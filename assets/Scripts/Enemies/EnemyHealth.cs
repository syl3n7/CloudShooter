using UnityEngine;

public class EnemyHealth : MonoBehaviour
{
    [SerializeField] private float initialHealth = 1f;
    [SerializeField] private int scoreValue = 10;
    [SerializeField] private HealthBar healthBar;
    private HealthManager healthManager;

    void Start()
    {
        healthManager = new HealthManager(initialHealth);
        healthBar.UpdateHealthBar(initialHealth, initialHealth);
    }

    public void TakeDamage(float damage)
    {
        healthManager.TakeDamage(damage, OnDeath);
        healthBar.UpdateHealthBar(healthManager.GetHealth(), initialHealth);
    }

    private void OnDeath()
    {
        if (healthBar != null)
        {
            healthBar.UpdateHealthBar(0, initialHealth);
        }
        GameController.Instance.AddScore(scoreValue);
        Destroy(gameObject);
    }

    void OnDestroy()
    {
        if (healthBar != null)
        {
            Destroy(healthBar.gameObject);
        }
    }
}