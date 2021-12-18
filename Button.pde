class Button{

//properties
float posX, posY;
boolean pressed = false;

    Button(){
        this.posX = 0; 
        this.posY = 0;
        pressed = false;
    }

    boolean pressed(){

        if(this.pressed){
            this.pressed = false;
            return true;
        }

        return pressed;
    }

}