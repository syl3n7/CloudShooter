class Menu{

//propriedades
float posX, posY;
boolean state;
Button button1, button2;
Highscore highscore;

    //construtor 
    Menu(float x, float y) {
        posX = x;
        posY = y;
        state = true;
        button1 = new Button("assets/images/refurbished_start_button.png", width/2 - 500, height/2 - 100); //image to be changed in the near future
        button2 = new Button("assets/images/refurbished_exit_button.png", width/2 + 100, height/2 - 100);
        highscore = new Highscore();
    }

    //método usado para desenhar os botões
    void start() {
        //verficar estado pressed de cada botao / desenhar jogo by default
        if(state){
            if (button1.pressed == true) state = false;
            if (button2.pressed == true) { ///pressionar botao exit guarda highscore e sai do jogo
                highscore.addData();
                highscore.saveData();
                exit();
            }
        }
    }
} 