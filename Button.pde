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
        //this code below is to check the hitboxes of the buttons
        //fill(255, 0, 0, 100); //manual debug
        //rect(posX+60, posY+60, tam1, tam2); //manual debug
    }

    //check mousepress on button, return value for pressed button
    boolean press(){
        if(mouseX > posX && mouseX < posX + tam1 && mouseY > posY && mouseY < posY + tam2*2 ){
            pressed = true;
        }
        return pressed;
    }
}