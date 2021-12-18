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
    posY = 0;
    tam = t;
    vel = v;
    damage = d;
    health = 100;

  }

  void drawme() {

    img.resize(int(tam), int(tam)); //redimensiona a imagem
    image(img, posX, posY);

  }

//necessito de fazer com que o enimigo se multiplique a cada posY completo 

//fazer enimigo andar pelo canvas variando velocidade horizontal e posicao vertical aleatoria
  void move() {
  
    //tam = randomGaussian();
    //tam = tam * dp + mediaY; 
    tsmoothed = noise(trand); //posicao vertical dinamica, dificuldade 0
    tsmoothed = map(tsmoothed, 0, 1, tam, width-tam);
    posY = tsmoothed;

    if (posX < 0) {
      delay(250);
      posX = width + tam;
     
    } else {
      posX -= vel;
      trand += 0.05;
      
    }

  }

/* placeholder para verificar se foi atingiho pela bala*/
  /* placeholder code 
  void healthcheck() {

    if (health <= 0) {
      enemy.hide();
    }

  }
  */
}
