class Menu{

//propriedades
float posX, posY;
boolean state;
Button start, exit, back, highscorestable, instructions, credits;
Highscore highscore;
Background background;
Instructions i;

    //construtor 
    Menu(float x, float y) {
        posX = x;
        posY = y;
        state = true;
        //background = new Background("assets/menu.png", 0, 0);
        start = new Button("assets/images/start_button.png", width/2 - 500, height/2 - 100); //image to be changed in the near future
        exit = new Button("assets/images/exit_button.png", width/2 + 100, height/2 - 100);
        back = new Button("assets/images/exit_button.png", 1600, 10);
        instructions = new Button("assets/images/instructions_button.png", width/2 - 500, height/2 + 200);
        highscorestable = new Button("assets/images/highscores_button.png", width/2 + 100, height/2 + 200);
        highscore = new Highscore();
        i = new Instructions(center_x, center_y, false);
    }

    //método usado para desenhar os botões
    void start() {
        //background.drawme();
        //verficar estado pressed de cada botao
        if(state){
              //testing dynamic background color
            if (bgc == 250) bgcUpperLimit = true;
            if (bgcUpperLimit == false) background(bgc++, 0, bgc, 0); //se parar de dar update ao background, funciona como um botao de pausa, maybe later ?
            if (bgc == 5) bgcUpperLimit = false; 
            if (bgcUpperLimit == true) background(bgc--, 0, bgc, 0);

            if (start.pressed) state = false;//se o botao start nao estiver a ser pressionado entao o menu continua a ser mostrado.
            if (exit.pressed) { ///pressionar botao exit guarda highscore e sai do jogo
                highscore.saveData();
                exit();
            } 
        }
        if(back.pressed) {
            highscore.addData();
            state = true;
            start.pressed = false;
            back.pressed = false;
        }
        if(instructions.pressed) {
            i.active = true;
        }
    }
} 
