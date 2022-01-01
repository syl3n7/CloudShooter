class Instructions {
//propriedades
float posX, posY;
boolean active;
String text1 = "1. Use WASD to move the player";
String text2 = "2. Use SPACE to fire a bullet at the enemy";
String text3 = "3. If you get hit by an enemy, you lose a life";
String text4 = "4. If you run out of lives, you lose";
String text5 = "5. If you get to certain highscore milestones, you unlock more types of bullets that deal more damage.";
color purple = color(#CE0FFA);
color white = color(#FBEAFF);
color red = color(#FA0000);
Button back;

//construtor
    Instructions(float x, float y, boolean b){
        posX = x;
        posY = y;
        active = b;
        back = new Button("assets/images/back_button.png", width-250, 80);
    }

    void drawme(){
        if (active);
            m.background.drawme();
            fill(red);
            textSize(64);
            text("Instructions", posX, height/4);
            textSize(32);
            fill(white);
            text(text1, posX, height/2);
            text(text2, posX, height/2 + 50);
            text(text3, posX, height/2 + 100);
            text(text4, posX, height/2 + 150);
            text(text5, posX, height/2 + 200);
    }
}