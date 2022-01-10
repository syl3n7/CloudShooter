class Button {
//properties
PImage button;
float posX, posY, tam1, tam2;
boolean pressed;
//construtor
    Button(String name, float x, float y) {
        button = loadImage(name);
        //button.resize(button.width/2, button.height/2);
        tam1 = 102;
        tam2 = 70;
        posX = x;
        posY = y;
        pressed = false;
    }
    void drawme() {

        

        image(button, posX, posY); //colocar isto na liunha 21 depois
        //this code below is to check the hitboxes of the buttons
        //fill(250, 0, 0, 70); //manual debug
        //rect(posX, posY, tam1, tam2); //manual debug
    }
    boolean press() { //check mousepress on button, return value for pressed button
        if(mouseX > posX-tam1 && mouseX < posX + tam1 && mouseY > posY-tam2 && mouseY < posY + tam2) {
            pressed = true;
        }
        return pressed;
    }
}