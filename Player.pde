class Player {
  //Properties
  float altura, largura; //altura e largura da imagem
  PImage img; //sprite normal
  //PImage img2; //sprite while moving up
  //PImage img3; //sprite while moving down
  float posX, posY, tam;
  boolean moveUp, moveDown, moveLeft, moveRight; //booleanas para controlar o movimento do player

  //Constructor
  Player(String n, float x, float y, float t) {
    img = loadImage(n);
    //img2 = loadimage(n2);
    //img3 = loadimage(n3);
    posX = x;
    posY = y;
    tam = t;
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
    image(img, posX, posY);
  }

  //damage radius
  void damage() {
  }

  void shoot () {
    b1.posX = posX+largura/2;
    b1.posY = posY+altura/3.5;
    b1.moveme();
  }

  //validar posicao e incremento da mesma caso tecla seja pressionada
  void moveme(){

    if (moveLeft) posX -= tam;  // "if(left == true)" igual a "if(left)"
    else if (moveRight) posX += tam;
    else if (moveUp) posY -= tam;
    else if (moveDown) posY += tam;

  }
  
  //codigo importado do exemplo do professor em ordem a obter movimento suave
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
