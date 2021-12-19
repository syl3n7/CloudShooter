
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
        button1 = new Button("assets/images/start_button.png", width/2 - 200, height/2);
        button2 = new Button("assets/images/exit_button.png", width/2 + 200, height/2);
        highscore = new Highscore();
    }

    //método usado para desenhar os botões
    void start() {
        //verficar estado pressed de cada botao / desenhar jogo by default
        while(state){
            button1.drawme();
            button2.drawme();
            if (button1.pressed == true) { 
                state = false;
            } else if (button2.pressed == true) { ///pressionar botao exit guarda highscore e sai do jogo
                highscore.addData();
                highscore.saveData();
                exit();
            } else {}
        }

        //claudio fez esta parte do codigo
        background(0, 80, 255); //background azul temporario
        c1.drawme(); //desenhar nuvem1
        c2.drawme(); //desenhar nuvem2
        c3.drawme(); //desenhar nuvem3
        c1.move(); //mover a nuvem1
        c2.move(); //mover a nuvem2
        c3.move(); //mover a nuvem3
        p1.drawme(); //desenhar o player1
        p1.moveme(); //mover o player1
        b1.drawme(); //desenhar as balas
        b1.moveme(); //mover as balas
        e1.drawme(); //desenhar o inimigo
        e1.move(); //Bmover o inimigo
        //  e1.healthcheck(); //verificar se o inimigo morreu ou nao
        score();
        b1.enemycheck(); //verificar se a bala atingiu o inimigo
    }
} 