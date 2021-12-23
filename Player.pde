class Player {
  //Properties
  float altura, largura; //altura e largura da imagem
  PImage img; //sprite normal
  String imgUp; //sprite while moving up
  //PImage img3; //sprite while moving down
  float posX, posY, tam, health;
  boolean moveUp, moveDown, moveLeft, moveRight; //booleanas para controlar o movimento do player

  //Constructor
  Player(String n, float x, float y, float t) {
    img = loadImage(n); //interligar isto ao playership menu
    imgUp = "assets/images/first_ship_secondcs.png";
    //imgDown = loadimage(imgDown);
    //imgLeft = loadimage(imgLeft);
    //imgRight = loadimage(imgRight);
    posX = x;
    posY = y;
    tam = t;
    health = 100;
    largura = img.width;
    altura = img.height;
    moveDown  = false;
    moveLeft  = false;
    moveRight = false;
    moveUp = false;  
  }

  //spawn da imagem mediante parametros indicados + resize para tamanho pretendido
  void drawme() {
    img.resize(650, 350);
    if(health > 0) {
      image(img, posX, posY); //missing the new sprite
    }
    checkDirection();
  }

  //check direction and change the sprite acordingly
  void checkDirection() {
    if(moveUp) {
      img = loadImage(imgUp); //missing the sprite
    }
    if(moveDown) {
      //img = loadImage(imgDown); //missing the sprite
    }
    if(moveLeft) {
      //img = loadImage(imgLeft); //missing the sprite
    }
    if(moveRight) {
      //img = loadImage(imgRight); //missing the sprite
    } 
  }

  //damage radius
  void damage() {
    //http://jeffreythompson.org/collision-detection/rect-rect.php
    //ler novamente o link acima. necessito de fazer a verificacao de colisao.
  }

  void shoot () {  
    b1.posX = posX+largura/2.5;
    b1.posY = posY+altura/3.4;
    b1.moveme();
  }

  //validar posicao e incremento da mesma caso tecla seja pressionada
  void moveme(){
    if (moveLeft) posX -= tam;  // "if(left == true)" igual a "if(left)"
    else if (moveRight) posX += tam;
    else if (moveUp) posY -= tam;
    else if (moveDown) posY += tam;
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
