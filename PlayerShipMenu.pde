class PlayerShipMenu{

//propriedades
float posX, posY;
boolean state;
Button start, exit, back, highscorestable, instructions, credits;
Highscore highscore;

    //construtor 
    Menu(float x, float y) {
        //background = loadImage("assets/images/background.png");
        posX = x;
        posY = y;
        state = true;
        select1 = new Button("assets/images/start_button.png", width/2 - 500, height/2 - 100); //image to be changed in the near future
        select2 = new Button("assets/images/exit_button.png", width/2 + 100, height/2 - 100);
    }

    //método usado para desenhar os botões
    void drawme() {
        //background = loadImage("assets/images/background.png");
        if (state){
            select1.drawme();
            select2.drawme();
        }
    }
} 
