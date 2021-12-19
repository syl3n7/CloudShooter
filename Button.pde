class Button{

//properties
PImage button;
float posX, posY;
boolean pressed = false;

    Button(String name, float x, float y){

        button = loadImage(name);
        posX = 0; 
        posY = 0;
        pressed = false;

    }

    void drawme(){
        image(button, posX, posY);
    }

    boolean pressed(){

        if(this.pressed){
            this.pressed = false;
            return true;
        }

        return pressed;
    }

}