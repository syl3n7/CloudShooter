using System.Collections;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour, IGameStateController
{
    private ScoreManager smanager;

    [Header("PlayerMovement")]
    
    public Rigidbody2D rb;
    [SerializeField] private InputActionAsset CustomInput;
    public float speed = 5f;
    private Vector2 movementInput;

    public InputAction moveAction;
    public InputAction fireAction;

    [Header("Shooting")]
    [SerializeField] private Transform bulletSpawnPoint;
    [SerializeField] private GameObject[] bulletPrefabs;
    [SerializeField] private GameObject[] casingPrefabs;
    public float fireRate = 0.5f;
    private float nextFireTime;

    [Header("PlayerSprites")]
    public SpriteRenderer spriteRenderer;
    private Sprite defaultSprite;
    private Sprite unlockedSprite1;
    private Sprite unlockedSprite2;
    private Sprite unlockedSprite3;
    private Sprite unlockedSprite4;

    [Header("Dashing")]
    [SerializeField] private float dashSpeedMultiplier = 2f;
    [SerializeField] private float dashDuration = 0.2f;
    [SerializeField] private float dashCooldown = 1f;
    [SerializeField] private float doubleTapTimeWindow = 0.2f;
    private float lastDashTime;
    private bool isDashing;
    public InputAction dashUpAction;
    public InputAction dashDownAction;
    public InputAction dashModifierAction;
    private float lastUpTapTime;
    private float lastDownTapTime;

    void Awake()
    {
        rb = GetComponent<Rigidbody2D>();
        var playerInput = GetComponent<PlayerInput>();
        moveAction = playerInput.actions["Move"];
        fireAction = playerInput.actions["Fire"];
        dashUpAction = playerInput.actions["DashUp"];
        dashDownAction = playerInput.actions["DashDown"];
        dashModifierAction = playerInput.actions["DashModifier"];
        spriteRenderer = GetComponent<SpriteRenderer>();
    }

    void Start()
    {
        //smanager = new ScoreManager(GameController.instance.highscore);
        defaultSprite = Resources.Load<Sprite>("Sprites/Player/first_ship_cs");
        unlockedSprite1 = Resources.Load<Sprite>("Sprites/Player/first_ship_secondcs");
        unlockedSprite2 = Resources.Load<Sprite>("Sprites/Player/first_ship_thirdcs");  
        unlockedSprite3 = Resources.Load<Sprite>("Sprites/Player/first_ship_fourthcs");
        unlockedSprite4 = Resources.Load<Sprite>("Sprites/Player/first_ship_fifthcs");
        LoadPlayerSprite();
    }

    private void Update()
    {
        if (Keyboard.current.escapeKey.isPressed)
        {
            // Handle escape key press for pause menu
        }

        HandleDashing();
        movementInput = moveAction.ReadValue<Vector2>();

        if (fireAction.ReadValue<float>() > 0 && Time.time >= nextFireTime)
        {
            Shoot();
            nextFireTime = Time.time + fireRate;
        }
    }

    private void HandleDashing()
    {
        if (isDashing)
            return;

        if (Time.time - lastDashTime < dashCooldown)
            return;

        if (!dashModifierAction.IsPressed())
            return;

        // Handle up dash
        if (dashUpAction.triggered)
        {
            float timeSinceLastUpTap = Time.time - lastUpTapTime;
            if (timeSinceLastUpTap <= doubleTapTimeWindow)
            {
                StartCoroutine(Dash(Vector2.up));
            }
            lastUpTapTime = Time.time;
        }

        // Handle down dash
        if (dashDownAction.triggered)
        {
            float timeSinceLastDownTap = Time.time - lastDownTapTime;
            if (timeSinceLastDownTap <= doubleTapTimeWindow)
            {
                StartCoroutine(Dash(Vector2.down));
            }
            lastDownTapTime = Time.time;
        }
    }

    private IEnumerator Dash(Vector2 direction)
    {
        isDashing = true;
        lastDashTime = Time.time;
        float originalSpeed = speed;
        speed *= dashSpeedMultiplier;

        yield return new WaitForSeconds(dashDuration);

        speed = originalSpeed;
        isDashing = false;
    }

    private void FixedUpdate()
    {
        rb.linearVelocity = movementInput * speed;
    }

    private void LoadPlayerSprite()
    {
        if (spriteRenderer == null)
        {
            Debug.LogError("SpriteRenderer is not assigned!");
            return;
        }

        int unlockedSpriteIndex = PlayerPrefs.GetInt("UnlockedSpriteIndex", 0); // Default to 0 if not set

        switch (unlockedSpriteIndex)
        {
            case 0:
                spriteRenderer.sprite = defaultSprite;
                break;
            case 1:
                spriteRenderer.sprite = unlockedSprite1;
                break;
            case 2:
                spriteRenderer.sprite = unlockedSprite2;
                break;
            case 3:
                spriteRenderer.sprite = unlockedSprite3;
                break;
            case 4:
                spriteRenderer.sprite = unlockedSprite4;
                break;
            default:
                spriteRenderer.sprite = defaultSprite;
                break;
        }
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Enemy"))
        {
            // Handle collision with enemy 
            Debug.Log("Collision detected with: " + collision.gameObject.tag);
        }
    }

    public void Dead()
    {
        //GameController.instance.highscore = smanager.GetScore();
    }

    public void Idle()
    {

    }

    public void Playing()
    {
        
    }

    private void Move(InputAction.CallbackContext context)
    {
        // This method can be used for other input actions if needed
    }

    private void OnEnable()
    {
        CustomInput.Enable();
    }
    private void OnDisable()
    {
        CustomInput.Disable();
    }

    private void Shoot()
    {
        int bulletIndex = 0; // Change based on current weapon level
        
        // Spawn bullet
        GameObject bullet = Instantiate(bulletPrefabs[bulletIndex], 
            bulletSpawnPoint.position, 
            bulletSpawnPoint.rotation);

        // Spawn casing
        GameObject casing = Instantiate(casingPrefabs[bulletIndex], 
            bulletSpawnPoint.position, 
            Quaternion.identity);
            
        if (casing.TryGetComponent<Rigidbody2D>(out var casingRb))
        {
            float ejectionForce = 2f;
            Vector2 ejectionDirection = new Vector2(Random.Range(-0.5f, -1f), Random.Range(0.5f, 1f));
            casingRb.AddForce(ejectionDirection * ejectionForce, ForceMode2D.Impulse);
        }

        Destroy(casing, 2f);
    }
}
