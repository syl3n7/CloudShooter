using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{

    [SerializeField] private Button start_bttn;
    [SerializeField] private Button exit_bttn;
    [SerializeField] private Button instructions_bttn;
    [SerializeField] private Button highscore_bttn;
    [SerializeField] private GameObject main_menu_panel;
    [SerializeField] private GameObject instructions_panel;
    [SerializeField] private GameObject highscore_panel;


    void Start()
    {
        start_bttn.onClick.AddListener(delegate
        {
            //carregar highscore antes de comecar o jogo
            start_game();
        });

        exit_bttn.onClick.AddListener(delegate
        {
            //guardar highscore antes de fechar
            Application.Quit();
        });

        instructions_bttn.onClick.AddListener(delegate
        {
            main_menu_panel.SetActive(false);
            instructions_panel.SetActive(true);
        });

        highscore_bttn.onClick.AddListener(delegate
        {
            main_menu_panel.SetActive(false);
            highscore_panel.SetActive(true);
        });
    }
    void start_game()
    {
        main_menu_panel.SetActive(false);
    }

    //bg.GetComponent<Image>().sprite = Spritexpto

    //jogar

    //sair (para poder guardar antes de fechar)

    //instrucoes

    //pontuacoes

}
