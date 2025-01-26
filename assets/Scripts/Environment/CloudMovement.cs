using UnityEngine;

public class CloudMovement : MonoBehaviour
{
    private float speed = 20f; 
    private Camera mainCamera;
    private float destroyOffset = -0.1f;

    void Start()
    {
        mainCamera = Camera.main;
        if (mainCamera == null)
        {
            Debug.LogError("Main camera not found!");
        }
    }

    public void Initialize(float moveSpeed)
    {
        speed = moveSpeed;
    }

    void Update()
    {
        if (mainCamera == null) return;

        transform.Translate(Vector3.left * speed * Time.deltaTime);
        
        float leftEdge = mainCamera.ViewportToWorldPoint(new Vector3(destroyOffset, 0, 0)).x;
        if (transform.position.x < leftEdge)
        {
            Destroy(gameObject, 1f);
        }
    }
}