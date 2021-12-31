class Menu{

//propriedades
float posX, posY;
boolean state;
Button start, exit, back, highscorebttn, instructions, credits;
Highscore highscore;
Background background;
Instructions i;

    //construtor 
    Menu(float x, float y) {
        posX = x;
        posY = y;
        state = true;//estado ativo ou desativo do menu.
        background = new Background("assets/background.png", 0, 0);
        start = new Button("assets/images/start_button.png", width/2 - 350, height/2 - 100);//botao para comecar o jogo
        exit = new Button("assets/images/exit_button.png", width/2 + 250, height/2 - 100);//botao para sair do jogo.
        back = new Button("assets/images/back_button.png", width-250, 80);//botao para retroceder
        instructions = new Button("assets/images/instructions_button.png", width/2 - 250, height/2 + 200);//botao para entrar nas instrucoes
        highscorebttn = new Button("assets/images/highscores_button.png", width/2 + 150, height/2 + 200);//botao para entrar na tabela de highscores
        highscore = new Highscore();//objeto que contem a informacao da tabela .csv Highscores
        i = new Instructions(center_x, center_y, false); //objeto contem o desenho (texto) das instructucoes.
    }

    //método usado para desenhar os botões
    void start() {
        background.drawme();
        //verficar estado pressed de cada botao
        if(state){
            if (start.pressed) displayGame = true;//se o botao start nao estiver a ser pressionado entao o menu continua a ser mostrado.
            if (exit.pressed) { ///pressionar botao exit guarda highscore e sai do jogo
                highscore.saveData();
                exit();
            } 
        }
        if(back.pressed) {
            highscore.addData();
            displayGame = false;
            p1.posX = -300; //para o player ir para a posicao inicial e fazer novamente a animacao de entrada
            p1.posY = height/2; //mesma coisa da linha de cima, mas para o eixo Y.
            p1.moveUnLock = false; //para a mesma coisa acima mencionada.
            start.pressed = false; 
            back.pressed = false;
        }
        if(instructions.pressed) {
            state = false;
            i.active = true;
        }
        if(i.back.pressed){
            i.active = false;
            state = true;
        }
    }
} 
