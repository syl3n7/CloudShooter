using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class Buttons : MonoBehaviour, IPointerDownHandler, IPointerUpHandler
{
    [SerializeField] private Sprite normalSprite;
    [SerializeField] private Sprite pressedSprite;
    [SerializeField] private GameObject PreviousPanel;
    [SerializeField] private GameObject CurrentPanel;
    private Image buttonImage;

    private void Awake()
    {
        buttonImage = GetComponent<Image>();
        if (buttonImage == null)
        {
            Debug.LogError("Button requires Image component!");
        }
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        if (pressedSprite != null)
        {
            buttonImage.sprite = pressedSprite;
        }
    }

    public void OnPointerUp(PointerEventData eventData)
    {
        if (normalSprite != null)
        {
            buttonImage.sprite = normalSprite;
        }
    }
}