class Player {
  //Properties
  PImage img; //sprite normal
  float posX, posY, tam, vel, health, dmg;
  int level;
  boolean moveUp, moveDown, moveLeft, moveRight, moveUnLock; //booleanas para controlar o movimento do player
  public ArrayList<Bullets> b1; //bullets
  //Constructor
  Player(String n, float x, float y) {
    img = loadImage(n); //carrega imagem especificada
    //imgUp = "assets/images/first_ship_secondcs.png";
    //imgDown = loadimage(imgDown);
    //imgLeft = loadimage(imgLeft);
    //imgRight = loadimage(imgRight);
    posX = x;
    posY = y;
    tam = 350/32; //tamanho = img resized
    vel = 350/16; //velocidade para movimentar a nave
    health = 100;
    dmg = 10;
    moveUnLock = true;
    moveDown  = false;
    moveLeft  = false;
    moveRight = false;
    moveUp = false;
    //nivel atual de dificuldade
    level = 0;
    //bullets
    b1 = new ArrayList<Bullets>();
    b1.add(new Bullets("assets/images/bullet_out_of_shell.png", -650, -650/2, 50));
    b1.add(new Bullets("assets/images/second_bullet_out_of_casing.png", -650, -650/2, 50));
    b1.add(new Bullets("assets/images/third_bullet_out_of_casing.png", -650, -650/2, 50));
  }
  //spawn da imagem mediante parametros indicados + resize para tamanho pretendido
  void drawme() {
    b1.get(level).drawme(); //desenhar as balas
    b1.get(level).moveme(); //mover as balas
    img.resize(350, 225);
    if(health > 0) image(img, posX, posY); //display sprite of player ship with position and health check updated every tick
    //checkDirection();
    fill(255, 0, 0, 200);
    //rect(posX+20, posY+10, 190, 80);
    textSize(24);
    text("Health: " + health, posX+20, posY-40);
    moveme();//mover o player1 //this now includes an animation on START to introduce the player into the canvas.
    damage(); //check if player hit the enemy and apply damage to enemy
  }
//damage radius 
  void damage() {
    //http://jeffreythompson.org/collision-detection/rect-rect.php
    if(dist(e1.get(level).posX, e1.get(level).posY, b1.get(level).posX, b1.get(level).posY) < b1.get(level).tam) {
      if (level == 1) dmg = 20;
      if (level == 2) dmg = 30;
      e1.get(level).health -= dmg;
    }
  }
  void shoot () {
    b1.get(level).posX = posX-img.width/8.5;
    b1.get(level).posY = posY+img.height/5.8;
    b1.get(level).drawme();
  }
  void lives (){
    if (lives == 0) {
      //game over
    } else if (health <= 0){
        lives--;
        health = 100;
      }
  }
//validar posicao e incremento da mesma caso tecla seja pressionada
  void moveme(){
    //player animation from outside of the canvas to the "spawn" position where the player can take over the controls.//tambem verifica se o player saiu de qq coordenada, x, -x, y, -y para retomar o player a sua area de jogo.
    if(posX < 200) posX += 10;
    if(posY < 100) posY += 10;
    if(posX > 1720) posX -= 10;
    if(posY > 980) posY -= 10;
    if (posX == 200) moveUnLock = true;
    //println(moveUnLock); usei isto para debug apenas.
    if(moveUnLock){ //lock player movement
      if (moveLeft) posX -= vel;  // "if(left == true)" igual a "if(left)"
      else if (moveRight) posX += vel;
      else if (moveUp) posY -= vel;
      else if (moveDown) posY += vel;
    }
  }
//codigo importado do exemplo do professor para movimento + suave
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
