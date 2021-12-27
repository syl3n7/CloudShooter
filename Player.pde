class Player {
  //Properties
  PImage img; //sprite normal
  float posX, posY, tam, health;
  boolean moveUp, moveDown, moveLeft, moveRight, moveUnLock; //booleanas para controlar o movimento do player
  Bullets b1; //bullets
  //Constructor
  Player(String n, float x, float y) {
    img = loadImage(n); //interligar isto ⬇️ ao playership menu
    //imgUp = "assets/images/first_ship_secondcs.png";
    //imgDown = loadimage(imgDown);
    //imgLeft = loadimage(imgLeft);
    //imgRight = loadimage(imgRight);
    posX = x;
    posY = y;
    tam = 350/16;//tamanho = img resized / 8
    health = 100;
    moveUnLock = true;
    moveDown  = false;
    moveLeft  = false;
    moveRight = false;
    moveUp = false;
    //bullet 1
    b1 = new Bullets("assets/images/bullet_out_of_shell.png", -650, -650/2, 75);
  }

  //spawn da imagem mediante parametros indicados + resize para tamanho pretendido
  void drawme() {
    b1.drawme(); //desenhar as balas
    b1.moveme(); //mover as balas
    img.resize(350, 225);
    if(health > 0) image(img, posX, posY); //display sprite of player ship with position and health check updated every tick
    //checkDirection();
  }

  //abandoned idea of changing sprite with direction, we instead opted for alowing the player to chose from sprites aka customization, unlocked with x amount of highscore.
  //check direction and change the sprite acordingly
  //  void checkDirection() {
  //   if(moveUp) {
  //     img = loadImage(imgUp); //missing the sprite
  //   }
  //   if(moveDown) {
  //     //img = loadImage(imgDown); //missing the sprite
  //   }
  //   if(moveLeft) {
  //     //img = loadImage(imgLeft); //missing the sprite
  //   }
  //   if(moveRight) {
  //     //img = loadImage(imgRight); //missing the sprite
  //   } 
  // }

//check decision on bullet type // should make this to work with score or dificulty. or both !
  // void bulletChoice() {
  //   if(buttonTBD.press) return = "/assets/images/bullet1.png";
  //   if(buttonTBD.press) return = "/assets/images/bullet2.png";
  //   if(buttonTBD.press) return "/assets/images/bullet3.png";
  // }

  //damage radius
  void damage() {
    //http://jeffreythompson.org/collision-detection/rect-rect.php
    //ler novamente o link acima. necessito de fazer a verificacao de colisao. 
    // i probably need to use the ellipse way to calculate this 
  }

  void shoot () {  
    b1.posX = posX-img.width/8.5;
    b1.posY = posY+img.height/5.8;
    b1.moveme();
  }

  //validar posicao e incremento da mesma caso tecla seja pressionada
  void moveme(){
    //player animation from outside of the canvas to the "spawn" position where the player can take over the controls.
    if(posX < 200) posX += 10;
    if (posX == 200) moveUnLock = true;
    println(moveUnLock);
    if(moveUnLock){ //lock player movement
      if (moveLeft) posX -= tam;  // "if(left == true)" igual a "if(left)"
      else if (moveRight) posX += tam;
      else if (moveUp) posY -= tam;
      else if (moveDown) posY += tam;
    }
  }
  
  //codigo importado do exemplo do professor em ordem a obter movimento + suave
  /*  void show() {
    if (die) {
      posY += 3*speed;   
    } else {
      if (left) posX -= speed;  // "if(left == true)" igual a "if(left)"
      else if (right) posX += speed;
      else if (up) posY -= speed;
      else if (down) posY += speed;
    }
    image(img, posX, posY);
  }
  */

}
