using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour, IGameStateController
{
    private ScoreManager smanager;

    [Header("PlayerMovement")]
    
    private CharacterController controller;
    private Vector3 playerVelocity;
    [SerializeField] private InputActionAsset CustomInput;
    public float speed;
    private float Hmovement;
    private float Vmovement;

    void Awake()
    {

    }

    void Start()
    {
        //smanager = new ScoreManager(GameController.instance.highscore);
    }

    private void Update()
    {
        if(Keyboard.current.escapeKey.isPressed)
        {
            
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
        Hmovement = context.ReadValue<Vector2>().x;
        Hmovement = context.ReadValue<Vector2>().y;
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
