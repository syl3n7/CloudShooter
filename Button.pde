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

    // boolean pressed(){

    //     if(this.pressed){
    //         this.pressed = false;
    //         return true;
    //     }

    //     return pressed;
    // }

}