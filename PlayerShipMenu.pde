class PlayerShipMenu{

//propriedades
float posX, posY;
boolean state;
Button ship1, ship2, ship3;
Background background;

    //construtor 
    PlayerShipMenu(float x, float y) {
        //background = new Background("assets/images/background.png", 0, 0);
        posX = x;
        posY = y;
        state = false;
        ship1 = new Button("assets/images/first_ship_cs.png", width/2 - 500, height/2 - 100); //image to be changed in the near future
        ship2 = new Button("assets/images/first_ship_secondcs.png", width/2 + 100, height/2 - 100);    //método usado para desenhar os botões
        ship3 = new Button("assets/images/first_ship_thirdcs.png", width/2 + 300, height/2 - 100);
    } 

    void drawme() {
        //background.drawme();
        if (state){
            background.drawme();
            ship1.drawme();
            ship2.drawme();
            ship3.drawme();
            shipColor();
            p1.drawme();
        }
    }

    //adicionar aqui metodo para escolher a nave e a bala do player
    //desbloqueaveis com highscore 
    void shipColor() {
        //logica para escolha na nave + return da string correta para definir
        if(state && m.state){
            if(ship1.press()) p1.img = loadImage("assets/images/first_ship_cs_pressed.png");
            if(ship2.press()) p1.img = loadImage("assets/images/first_ship_secondcs_pressed.png");
            if(ship3.press()) p1.img = loadImage("assets/images/first_ship_thirdcs_pressed.png"); 
        }
    }
}
