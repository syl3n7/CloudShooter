class Enemy {
  //propriedades
  float trand = 5;
  float tsmoothed;
  PImage img;
  float posX, posY, vel, damage, tam;
  int health;
  //constructor
  Enemy(String nome) {
    img = loadImage(nome);
    posX = width-tam;
    posY = height/2;
    tam = 150;
    vel = 5;
    damage = 5;
    health = 100;
  }
  void drawme() {
    img.resize(int(tam), int(tam)); //redimensiona a imagem
    if(health > 0) image(img, posX, posY);
    //fill(255, 0, 0, 200); //hitbox debug only
    //rect(posX, posY+10, 150, 70); //hitbox debug only
    textSize(24);
    text("Health: " + health, posX, posY-40);
    move();
  }
//necessito de fazer com que o enimigo se multiplique a cada posX completo.
//usar um array de objetos de enimigos onde vao dando spawn a cada posX completo.
  void move() { //fazer inimigo andar pelo canvas variando velocidade horizontal e posicao vertical aleatoria
    tsmoothed = noise(trand); //posicao vertical dinamica, dificuldade 0
    tsmoothed = map(tsmoothed, 0, 1, tam, width-tam);
    posY = tsmoothed;
    if (posY < 500) posY += vel; //nao sair do canvas para baixo
    if (posY > 600) posY -= vel; //nao sair do canvas para cima
    if (posX < 0 ) {
      posX = width + tam;
    } else {
      posX -= vel;
      if (p1.level == 0) {
        trand += 0.005;
      }else if (p1.level == 1) {
        trand += 0.09;
      }else if (p1.level == 2) {
        trand += 0.3;
      }
    }
    healthcheck(); //verificar a cada movimento a vida do inimigo
  }
  void healthcheck() { //when it, turns red
    if(health < health/2){
        img.loadPixels();
        for(int x = 0; x < img.width; x++) {
            for(int y = 0; y < img.height; y++) {
                if(blue(img.pixels[x+y*img.width]) > 128) {
                    img.pixels[x+y*img.width] = color(128, 0, 0);
                }
            }
        }
        img.updatePixels();
    }
    if (p1.level == 1) health = 200;
    if (p1.level == 2) health = 300;
  }
}