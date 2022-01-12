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
    posX = x;
    posY = y;
    tam = 350/32; //tamanho = img resized
    vel = 350/16; //velocidade para movimentar a nave
    health = 100;
    dmg = 10; //dano da bala no nivel 0, se o level subir, tem ifs em baixo para mudar o valor desta variavel.
    moveUnLock = true;
    moveDown  = false;
    moveLeft  = false;
    moveRight = false;
    moveUp = false;
    level = 0;  //nivel atual de dificuldade
    b1 = new ArrayList<Bullets>(300); //bullets
    for (int i = 0; i < 100; i++) { //cria 10 bullets (tamanho depois alterado na classe principal consoante dificuldade)
      b1.add(new Bullets("assets/images/bullet_out_of_shell.png", -650, -650/2, 50)); //adicionar 10 inimigos ao array list, se a dificuldade for superior, ele aumenta o array.
    }
  }
  void drawme() { //spawn da imagem mediante parametros indicados + resize para tamanho pretendido
    for (int i = 0; i < int(p1.level*100); i++) { //precorrer o tamanho do array de inimigos
      b1.get(i).drawme(); //desenhar as balas
      b1.get(i).moveme(); //mover as balas
    }
    img.resize(350, 225); // redimensionar imagem das balas para tamanho do cano da nave
    if(health > 0) image(img, posX, posY); //display sprite of player ship with position and health check updated every tick
    fill(255, 0, 0, 200);
  //rect(posX+20, posY+10, 190, 80);
    textSize(24);
    text("Health: " + health, posX+20, posY-40);
    moveme(); //mover o player1 //this now includes an animation on START to introduce the player into the canvas.
    damage(); //check if player hit the enemy and apply damage to enemy
  } 
  void damage() { //aplicar dano ao enimigo da bala da nave, consoante o nivel atual //http://jeffreythompson.org/collision-detection/rect-rect.php
    if(dist(e1.get(level).posX, e1.get(level).posY, b1.get(level).posX, b1.get(level).posY) < b1.get(level).tam) {
      if (level == 1) dmg = 20;
      if (level == 2) dmg = 30;
      e1.get(level).health -= dmg;
    }
  }
  void shoot () { // mover a bala, desenhar a bala posicionar a imagem da bala
    b1.get(level).posX = posX-img.width/8.5;
    b1.get(level).posY = posY+img.height/5.8;
    b1.get(level).drawme();
  }
  void lives (){
    if (lives == 0) { //game over
    } else if (health <= 0){
        lives--;
        health = 100;
      }
  }
  void moveme() {  //validar posicao e incremento da mesma caso tecla seja pressionada
    //verifica se o player saiu de qq coordenada, x,y,-x,-y para retomar o player a sua area de jogo.
    if(posX < 200) posX += 10;
    if(posY < 100) posY += 10;
    if(posX > 1720) posX -= 10;
    if(posY > 980) posY -= 10;
    if (posX == 200) moveUnLock = true; //animacao inicial para o player sair do spawn area e ir ate a area de jogo
    //println(moveUnLock); usei isto para debug apenas. 
    //codigo da linha 80 a 84 importado do exemplo do professor para movimento + suave
    if(moveUnLock) { //lock player movement
      if (moveLeft) posX -= vel;  // "if(left == true)" igual a "if(left)"
      else if (moveRight) posX += vel;
      else if (moveUp) posY -= vel;
      else if (moveDown) posY += vel;
    }
  }
}