class Enemy {

  //propriedades
  float dp = 37;
  float trand = 5;
  float tsmoothed;
  PImage img;
  float posX, posY, vel, damage, tam;
  int health;
  float mediaY = height/2;
  //constructor
  Enemy(String nome, float x, float y, int t, float v, float d) {
    img = loadImage(nome);
    posX = width-tam;
    posY = height/2;
    tam = t;
    vel = v;
    damage = d;
    health = 100;
  }
//necessito de chamar recursivamente esta funcao para que o jogador possa eliminar o inimigo e ele continue a dar spawn
  void drawme() {
    img.resize(int(tam), int(tam)); //redimensiona a imagem
    image(img, posX, posY);
    fill(255, 0, 0, 100);
    rect(posX, posY+10, 150, 70);
    move();
  }
//necessito de fazer com que o enimigo se multiplique a cada posX completo.
//usar um array de objetos de enimigos onde vao dando spawn a cada posX completo.

//fazer enimigo andar pelo canvas variando velocidade horizontal e posicao vertical aleatoria
  void move() {
    //tam = randomGaussian();
    //tam = tam * dp + mediaY;
    tsmoothed = noise(trand); //posicao vertical dinamica, dificuldade 0
    tsmoothed = map(tsmoothed, 0, 1, tam, width-tam);
    posY = tsmoothed;
    if (posX < 0 ) {
      posX = width + tam;
    } else {
      posX -= vel;
      trand += 0.0009;
    }
  }
  void healthcheck() { //when it, turns red
    if(p1.health < 25){
        img.loadPixels();
        for(int x = 0; x < width; x++) {
            for(int y = 0; y < height; y++) {
                if(blue(img.pixels[x+y*img.width]) > 128) {
                    img.pixels[x+y*img.width] = color(128, 0, 0);
                }
            }
        }
        img.updatePixels();
    }
  }
}