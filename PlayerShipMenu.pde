class PlayerShipMenu{

//propriedades
float posX, posY;
boolean state;
Button ship1, ship2;
Background background;

    //construtor 
    PlayerShipMenu(float x, float y) {
        background = new Background("assets/images/background.png", 0, 0);
        posX = x;
        posY = y;
        state = false;
        ship1 = new Button("assets/images/first_ship_cs.png", width/2 - 500, height/2 - 100); //image to be changed in the near future
        ship2 = new Button("assets/images/first_ship_secondcs.png", width/2 + 100, height/2 - 100);    //método usado para desenhar os botões
    } 

    void drawme() {
        background.drawme();
        if (m.state && state){
            ship1.drawme();
            ship1.drawme();
        }
    }
}
