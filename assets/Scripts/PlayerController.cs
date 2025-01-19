using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour, IGameStateController
{
    private ScoreManager smanager;

    [Header("PlayerMovement")]
    
    private Rigidbody2D rb;
    [SerializeField] private InputActionAsset CustomInput;
    public float speed;
    private Vector2 movementInput;

    private InputAction moveAction;

    [Header("PlayerSprites")]
    private SpriteRenderer spriteRenderer;
    private Sprite defaultSprite;
    private Sprite unlockedSprite1;
    private Sprite unlockedSprite2;
    private Sprite unlockedSprite3;
    private Sprite unlockedSprite4;

    void Awake()
    {
        rb = GetComponent<Rigidbody2D>();
        var playerInput = GetComponent<PlayerInput>();
        moveAction = playerInput.actions["Move"];
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

        movementInput = moveAction.ReadValue<Vector2>();
    }

    private void FixedUpdate()
    {
        Vector2 move = movementInput * speed * Time.fixedDeltaTime;
        rb.linearVelocity = move;
    }

    private void LoadPlayerSprite()
    {
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
        if (collision.gameObject.CompareTag("enemy") || 
            collision.gameObject.CompareTag("bullet1") || 
            collision.gameObject.CompareTag("bullet2") || 
            collision.gameObject.CompareTag("bullet3"))
        {
            // Handle collision with enemy or bullets
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
}
