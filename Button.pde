class Button{

//properties
PImage button;
float posX, posY;
boolean pressed;

    Button(String name, float x, float y){
        button = loadImage(name);
        button.resize(button.width/2, button.height/2);
        posX = x;
        posY = y;
        pressed = false;
    }

    void drawme(){
        image(button, posX, posY);
    }

//i want to use this so that i dont mess with the variable outside of the class
    // boolean pressed(){

    //     if(pressed){
    //         pressed = false;
    //         return true;
    //     }

    //     return pressed;
    // }

}