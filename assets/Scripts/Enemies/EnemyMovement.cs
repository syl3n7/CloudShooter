using UnityEngine;

public class EnemyMovement : MonoBehaviour
{
    public float speed = 3f;
    public int damageAmount = 10;
    
    private Camera mainCamera;
    private Rigidbody2D rb;

    void Start()
    {
        mainCamera = Camera.main;
        rb = GetComponent<Rigidbody2D>();
    }

    void FixedUpdate()
    {
        // Move left using physics
        rb.linearVelocity = Vector2.left * speed;
    }

    void Update()
    {
        // Check if enemy is visible in camera
        Vector3 viewportPoint = mainCamera.WorldToViewportPoint(transform.position);
        if (viewportPoint.x < -0.1f) // Slightly off screen
        {
            Destroy(gameObject);
        }
    }

    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Player"))
        {
            Debug.Log("i kamikazed the player");
        }
    }
}