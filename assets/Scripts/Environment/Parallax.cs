using UnityEngine;

public class Parallax : MonoBehaviour
{
    private float parallaxSpeed;
    private Camera mainCamera;
    private Vector3 startPosition;
    private float length;

    public void Initialize(float speed)
    {
        parallaxSpeed = speed;
        mainCamera = Camera.main;
        startPosition = transform.position;
        length = GetComponent<SpriteRenderer>().bounds.size.x;
    }

    void Update()
    {
        // Move layer left continuously
        transform.Translate(Vector3.left * parallaxSpeed * Time.deltaTime);
        
        // Check if layer needs to be repositioned
        if (transform.position.x + length < mainCamera.transform.position.x)
        {
            transform.position = new Vector3(transform.position.x + length * 3, transform.position.y, transform.position.z);
        }
    }
}