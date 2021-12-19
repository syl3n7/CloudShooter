
class Menu{

//propriedades
float posX, posY;
boolean state;
Button button1, button2;

    //construtor 
    Menu(float x, float y) {

        posX = x;
        posY = y;
        state = true;
        button1 = new Button("assets/Start.png", posX, posY);
        button2 = new Button("assets/Exit.png", posX, posY + 50);

    }

    //método usado para desenhar os botões
    void start() {

        if (state == true) { //desenha os botões

            button1.drawme();
            button2.drawme();

        } else {
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

} 