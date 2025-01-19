using UnityEngine;

public class EnemyMovement : MonoBehaviour
{
    public float speed = 3f; // Adjust speed per enemy type

    void Update()
    {
        transform.Translate(Vector3.left * speed * Time.deltaTime);

        // Destroy enemy if it goes off-screen
        if (transform.position.x < -10f)
        {
            Destroy(gameObject);
        }
    }
}