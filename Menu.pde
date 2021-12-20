class Menu{

//propriedades
float posX, posY;
boolean state;
Button start, exit, back;
Highscore highscore;

    //construtor 
    Menu(float x, float y) {
        posX = x;
        posY = y;
        state = true;
        start = new Button("assets/images/refurbished_start_button.png", width/2 - 500, height/2 - 100); //image to be changed in the near future
        exit = new Button("assets/images/refurbished_exit_button.png", width/2 + 100, height/2 - 100);
        back = new Button("assets/images/refurbished_exit_button.png", 1600, 10);
        highscore = new Highscore();
    }

    //método usado para desenhar os botões
    void start() {
        //verficar estado pressed de cada botao
        if(state){
            if (start.pressed) state = false;
            if (exit.pressed) { ///pressionar botao exit guarda highscore e sai do jogo
                highscore.addData();
                highscore.saveData();
                exit();
            }
        }
        if(back.pressed) {
            println("start pressed "+start.pressed);
            println("state "+state);
            state = true;
            start.pressed = false;
            highscore.addData();
        }
    }
} 
