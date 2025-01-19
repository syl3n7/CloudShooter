using UnityEditor.iOS;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour, IGameStateController
{
    private ScoreManager smanager;

    [Header("PlayerMovement")]

    private Vector3 playerVelocity;
    [SerializeField] private InputActionAsset CustomInput;
    public float speed;
    private float Hmovement;
    private float Vmovement;
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
        var playerInput = GetComponent<PlayerInput>();
        moveAction = playerInput.actions["Move"];
        spriteRenderer = GetComponent<SpriteRenderer>();
    }

    void Start()
    {
        //smanager = new ScoreManager(GameController.instance.highscore);
        defaultSprite = Resources.Load<Sprite>("Sprites/default");
        //unlockedSprite1
        //unlockedSprite2
        //unlockedSprite3
        //unlockedSprite4
        LoadPlayerSprite();
    }

    private void Update()
    {
        if (Keyboard.current.escapeKey.isPressed)
        {
            // Handle escape key press for pause menu
        }

        Vector2 input = moveAction.ReadValue<Vector2>();
        Hmovement = input.x;
        Vmovement = input.y;

        Vector3 move = new Vector3(Hmovement, Vmovement, 0) * speed * Time.deltaTime;
        transform.position += move;
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
            // Add more cases as needed
            default:
                spriteRenderer.sprite = defaultSprite;
                break;
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
