class Button{

//properties
PImage button;
float posX, posY, tam1, tam2;
boolean pressed;

    Button(String name, float x, float y){
        button = loadImage(name);
        //button.resize(button.width/2, button.height/2);
        tam1 = 210;
        tam2 = 130;
        posX = x;
        posY = y;
        pressed = false;
    }

    void drawme(){
        image(button, posX, posY);//colocar isto na liunha 21 depois
        //fill(255, 0, 0, 100); //manual debug
        //rect(posX+60, posY+60, tam1, tam2); //manual debug
    }

//i want to use this so that i dont mess with the variable outside of the class
    boolean pressed(){
        if(mouseX > posX && mouseX < posX + tam1 && mouseY > posY && mouseY < posY + tam2*2 ){
            pressed = true;
        }
        return pressed;
    }
}