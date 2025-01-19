using UnityEngine;

public class EnemyMovement : MonoBehaviour
{
    public float speed = 3f;
    public int damageAmount = 10;
    public float destroyDelay = 5f;
    
    private Camera mainCamera;
    private Rigidbody2D rb;
    private bool hasLeftScreen = false;
    private float timeLeftScreen = 0f;

    void Start()
    {
        mainCamera = Camera.main;
        rb = GetComponent<Rigidbody2D>();
    }

    void FixedUpdate()
    {
        rb.velocity = Vector2.left * speed;
    }

    void Update()
    {
        Vector3 viewportPoint = mainCamera.WorldToViewportPoint(transform.position);
        
        if (viewportPoint.x < -0.1f)
        {
            if (!hasLeftScreen)
            {
                hasLeftScreen = true;
                timeLeftScreen = Time.time;
            }
            else if (Time.time - timeLeftScreen >= destroyDelay)
            {
                Destroy(gameObject);
            }
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