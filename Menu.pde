//catarina codigo abaixo
class Menu{
//para catarina comentar o codigo abaixo

//properties
float posX, posY;
boolean state;
Button b1, b2;

    //constructor 
    Menu(float x, float y) {

        posX = x;
        posY = y;
        state = true;
        b1 = new Button(posX, posY, "Start");
        b2 = new Button(posX, posY + 50, "Exit");


    }

//method to 
    void start() {

        if (state == true) {

            b1.buttonStart();
            b2.buttonStart();

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
            e1.drawme(); //desenhar o enimigo
            e1.move(); //Bmover o enimo
            //  e1.healthcheck(); //verificar se o enimigo morreu ou nao
            score();
            b1.enemycheck(); //verificar se a bala atingiu o enimigo 

        }

    }

}

