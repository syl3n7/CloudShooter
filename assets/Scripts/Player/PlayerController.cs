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

    [Header("Health and Lives")]
    [SerializeField] private float maxHealth = 100f;
    [SerializeField] private int maxLives = 3;
    private HealthManager healthManager;
    private int currentLives;
    [SerializeField] private HealthBar healthBar;
    private bool isTakingDamage = false;
    private float damageTickRate = 1f; // Time between damage ticks
    private bool isInvulnerable = false;
    private float invulnerabilityDuration = 2f;

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

        // Configure Rigidbody2D
        rb.gravityScale = 0f;
        rb.linearDamping = 5f;
        rb.constraints = RigidbodyConstraints2D.FreezeRotation;
    }

    void Start()
    {
        //smanager = new ScoreManager(GameController.instance.highscore);
        defaultSprite = Resources.Load<Sprite>("Sprites/Player/first_ship_cs");
        unlockedSprite1 = Resources.Load<Sprite>("Sprites/Player/first_ship_secondcs");
        unlockedSprite2 = Resources.Load<Sprite>("Sprites/Player/first_ship_thirdcs");
        unlockedSprite3 = Resources.Load<Sprite>("Sprites/Player/first_ship_fourthcs");
        unlockedSprite4 = Resources.Load<Sprite>("Sprites/Player/first_ship_fifthcs");
        InitializeHealth();
        LoadPlayerSprite();

        StartCoroutine(MovePlayerToPos());
    }

    private void InitializeHealth()
    {
        healthManager = new HealthManager(maxHealth);
        currentLives = maxLives;
        if (healthBar != null)
        {
            healthBar.UpdateHealthBar(maxHealth, maxHealth);
        }
        UIManager.Instance.UpdateLivesDisplay(currentLives);
    }

    private IEnumerator MovePlayerToPos()
    {
        Vector3 startPos = new Vector3(-1500f, transform.position.y, transform.position.z);
        Vector3 endPos = new Vector3(-600f, transform.position.y, transform.position.z);

        transform.position = startPos;
        float elapsedTime = 0f;
        float moveTime = 2f; // Adjust duration as needed

        while (elapsedTime < moveTime)
        {
            elapsedTime += Time.deltaTime;
            float t = elapsedTime / moveTime;
            transform.position = Vector3.Lerp(startPos, endPos, t);
            yield return null;
        }

        transform.position = endPos;
    }

    private void Update()
    {
        if (Keyboard.current.escapeKey.wasPressedThisFrame)
        {
            if (GameController.Instance.gameManager == GameManager.Playing)
            {
                UIManager.Instance.PauseGame();
            }
            else if (GameController.Instance.gameManager == GameManager.Paused)
            {
                UIManager.Instance.ResumeGame();
            }
        }

        if (GameController.Instance.gameManager != GameManager.Playing)
        {
            rb.linearVelocity = Vector2.zero;
            return;
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
        if (GameController.Instance.gameManager != GameManager.Playing)
            return;

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
            if (collision.gameObject.TryGetComponent<EnemyMovement>(out var enemy))
            {
                TakeDamage(enemy.damageAmount);
                Debug.Log("Player hit by enemy, taking " + enemy.damageAmount + " damage.");
            }
        }
    }

    private void OnCollisionExit2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Enemy"))
        {
            isTakingDamage = false;
        }
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if ((other.CompareTag("Enemy") || other.CompareTag("EnemyFast") || other.CompareTag("EnemyTough")) && !isInvulnerable)
        {
            if (other.TryGetComponent<EnemyMovement>(out var enemy))
            {
                TakeDamage(enemy.damageAmount);
                Debug.Log("Player hit by enemy, taking " + enemy.damageAmount + " damage.");
            }
        }
    }

    private void OnTriggerExit2D(Collider2D other)
    {
        if (other.CompareTag("Enemy") || other.CompareTag("EnemyFast") || other.CompareTag("EnemyTough"))
        {
            isTakingDamage = false;
        }
    }

    public void TakeDamage(float damage)
    {
        if (!isTakingDamage && !isInvulnerable)
        {
            StartCoroutine(DamageOverTime(damage));
        }
    }

    private IEnumerator DamageOverTime(float damage)
    {
        isTakingDamage = true;
        while (isTakingDamage)
        {
            healthManager.TakeDamage(damage, OnDeath);
            if (healthBar != null)
            {
                healthBar.UpdateHealthBar(healthManager.GetHealth(), maxHealth);
            }
            Debug.Log("Player health: " + healthManager.GetHealth());
            yield return new WaitForSeconds(damageTickRate);
        }
    }

    private void OnDeath()
    {
        currentLives--;
        UIManager.Instance.UpdateLivesDisplay(currentLives);
        if (currentLives <= 0)
        {
            GameOver();
        }
        else
        {
            StartCoroutine(Respawn());
        }
    }

    private IEnumerator Respawn()
    {
        isInvulnerable = true;
        healthManager.ChangeHealth(maxHealth);
        if (healthBar != null)
        {
            healthBar.UpdateHealthBar(maxHealth, maxHealth);
        }

        // Blinking effect
        for (int i = 0; i < invulnerabilityDuration * 5; i++)
        {
            spriteRenderer.enabled = !spriteRenderer.enabled;
            yield return new WaitForSeconds(0.2f);
        }
        spriteRenderer.enabled = true;
        isInvulnerable = false;
        isTakingDamage = false;
        //!Reset position - removed temporarily, will acess later.
        //*transform.position = new Vector3(-600f, 0f, 0f);
    }

    private void GameOver()
    {
        GameController.Instance.ChangeState(GameManager.Dead);
        gameObject.SetActive(false);
    }

    public void Dead()
    {
        gameObject.SetActive(false);
    }

    public void Idle()
    {
        gameObject.SetActive(false);
    }

    public void Playing()
    {
        gameObject.SetActive(true);
        InitializeHealth();
        LoadPlayerSprite();
        StartCoroutine(MovePlayerToPos());
    }

    public void Paused() { }

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
