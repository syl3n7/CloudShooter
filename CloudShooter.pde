import java.awt.*;//importar libraria grafica
//declarar objetos
public Menu m;
boolean displayGame = false;
CloudsGen c1, c2, c3, c4, c5;
PlayerShipMenu pm;
public Player p1;
public ArrayList<Enemy> e1;
public int score, lives, center_x, center_y;
public float hits;

void setup() { //codigo apenas executado no inicio do programa
  surface.setTitle("CloudShooter by Catarina & Claudio"); //titulo da janela
  fullScreen(0,P2D); //fullscreen
  frameRate(60); //especificar framerate a usar
  Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize(); //https://forum.processing.org/one/topic/dynamic-screen-background-resize-need-guidance.html //dinamic window size begin (without borders) //ir buscar a dimensao da tela
  int screenWidth = screenSize.width; //ir buscar a largura da tela
  int screenHeight = screenSize.height; //ir buscar a largura da tela
  surface.setSize(1920, 1080 /*screenWidth, screenHeight*/);
  smooth(8); //funcao de antialiasing
  center_x = screenWidth/2-width/2; //centrar a janela no eixo X
  center_y = screenHeight/2-height/2; //centrar a janela no eixo Y
  surface.setLocation(center_x, center_y); //set location of canvas to center of screen resolution
  imageMode(CENTER); //funcao para centrar o spawn de imagens
  rectMode(CENTER); //função para centrar o spawn de rectângulos
  textAlign(CENTER); //funcao para alinhar o texto ao centro 
  noStroke(); //funcao para retirar o Stroke das figuras geometricas
//Inicializar Objetos
  score = 0;
  lives = 3;
  m = new Menu(width/2, height/2); //menu
  pm = new PlayerShipMenu(width/2, height/2); //menu para escolha de "nave" usa bala e imagem diferente
  c1 = new CloudsGen("/assets/images/cloud1.png", 100, random(height)); //nuvem 1
  c2 = new CloudsGen("/assets/images/cloud2.png", 200, random(height)); //nuvem 2
  c3 = new CloudsGen("/assets/images/cloud3.png", 300, random(height)); //nuvem 3
  c4 = new CloudsGen("/assets/images/cloud4.png", 400, random(height)); //nuvem 4
  c5 = new CloudsGen("/assets/images/cloud5.png", 500, random(height)); //nuvem 5
  p1 = new Player("/assets/images/first_ship_cs.png", -200, height/2); //player 1 //spawn fora do canvas para animar a entrada do player no jogo
  e1 = new ArrayList<Enemy>(30); //enemy 1 (necessario tornar isto num array list de waves para attack)
  for (int i = 0; i < 10; i++) { //
    e1.add(new Enemy("/assets/images/AlienSpaceship.png")); //adicionar 10 inimigos ao array list, se a dificuldade for superior, ele aumenta o array.
  }
  hits = e1.get(p1.level).health/p1.dmg;
}
void draw() { //desenhar os elementos do programa no ecra mediante condicoes especificadas
  m.start(); //verifica presses
  if (m.i.active) { //instrucoes ativos
    m.i.drawme();
    m.i.back.drawme();
  } if (pm.state && score >= hits) { //player menu = escolha de cor para a nave (desbloqueia com x score)
    pm.drawme();
    pm.back.drawme();
    pm.ship1.drawme();
    pm.ship2.drawme();
    pm.ship3.drawme();
  } if (m.highscore.active) { //highscore ativos
    m.highscore.drawme();
    m.highscore.back.drawme();
  } if (m.state) { //menu ativo
    m.start.drawme();
    m.exit.drawme();
    m.highscorebttn.drawme();
    m.instructionsbttn.drawme();
  } if (displayGame) { //jogo ativo
    m.background.drawme();
    m.back.drawme(); //desenhar o botão de pausa
    c1.drawme(); //desenhar e mover nuvem1
    c2.drawme(); //desenhar e mover nuvem2
    c3.drawme(); //desenhar e mover nuvem3
    c4.drawme(); //desenhar e mover nuvem4
    c5.drawme(); //desenhar e mover nuvem5
    p1.drawme(); //desenhar e mover o player1
    for (int i = 0; i < int(p1.level*10); i++) { //precorrer o tamanho do array de inimigos
      e1.get(i).drawme(); //desenhar os inimigos do array list
    }
    score(); //incrementar score
    changeArraySizeOnDifficultyChange(); //alterar tamanho do array list de inimigos
    changeBulletSizeOnDifficultyChange(); //alterar tamanho da bala
  }
}
void changeBulletSizeOnDifficultyChange(){ // mudar o tipo de bala consoante nivel de dificuldade
  if (p1.level == 1){
    for (int i = 0; i < 100; i++) { //remover os 10 inimigos do array list
      p1.b1.remove(new Bullets("assets/images/bullet_out_of_shell.png", -650, -650/2, 50)); 
    }
    for (int i = 0; i < 200; i++) { //adicionar 20 inimigos ao array list
      p1.b1.add(new Bullets("assets/images/second_bullet_out_of_casing.png", -650, -650/2, 50)); 
    }
  }
  if(p1.level == 2){
    for (int i = 0; i < 200; i++) { //remover os 20 inimigos do array list
      p1.b1.remove(new Bullets("assets/images/second_bullet_out_of_casing.png", -650, -650/2, 50)); 
    }
    for (int i = 0; i < 300; i++) { //adicionar 30 inimigos ao array list
      p1.b1.add(new Bullets("assets/images/third_bullet_out_of_casing.png", -650, -650/2, 50)); 
    }
  }
}
void changeArraySizeOnDifficultyChange() { // alterar tipo de inimigo ao aumentar wave.
  if (p1.level == 1){
    for (int i = 0; i < 10; i++) { //remover os 10 inimigos do array list
      e1.remove(new Enemy("/assets/images/AlienSpaceship.png")); 
    }
    for (int i = 0; i < 20; i++) { //adicionar 20 inimigos ao array list
      e1.add(new Enemy("/assets/images/AlienSpaceship_secondcs.png")); 
    }
  }
  if(p1.level == 2){
    for (int i = 0; i < 20; i++) { //remover os 20 inimigos do array list
      e1.remove(new Enemy("/assets/images/AlienSpaceship_thirdcs.png")); 
    }
    for (int i = 0; i < 30; i++) { //adicionar 30 inimigos ao array list
      e1.add(new Enemy("/assets/images/AlienSpaceship_thirdcs.png")); 
    }
  }
}
void keyPressed() {
  if (key == ' ') p1.shoot(); // disparar a bala ate width, se pressionado novamente, da reset a posicao da bala e volta a desenhar ate width
//codigo para movimento importado do exemplo fornecido pelo professor
  if(key == 's'|| key == 'S') p1.moveDown = true;
  if(key == 'w'|| key == 'W') p1.moveUp = true;
  if(key == 'a'|| key == 'A') p1.moveLeft = true;
  if(key == 'd'|| key == 'D') p1.moveRight = true;
}
void keyReleased() {
  if(key == 's'|| key == 'S') p1.moveDown = false;
  if(key == 'w'|| key == 'W') p1.moveUp = false;
  if(key == 'a'|| key == 'A') p1.moveLeft = false;
  if(key == 'd'|| key == 'D') p1.moveRight = false;
}
void healthcheck(){ //verificar se o player colidiu com o inimigo // passar isto para o codigo do player noutra funcao e correr dentro da funcao movimento. // tambem preciso de colocar as colisoes a funcionar em forma de retangulo (mais simples de implementar do que poligonos ou ellipse)
  //put here code for checking between bullet and enemy
  // float distX = p1.posX - e1.get(p1.level).posX;
  // float distY = p1.posY - e1.get(p1.level).posY;
  // float distance = sqrt((distX*distX) + (distY*distY)); //(PI * (190/2) * (80/2)) + (PI * (150/2) * (70/2));
  // if (distance <= distX + distY) p1.health -= 10;//if distance is less than PI than the radius of the enemy, then the player loses health (10)
  // if (distance <= distX + distY) e1.health -= p1.b1.damage;
}
//acrescentar pontuacao na tabela
void score() {
  textSize(32); // era fixe colocar isto numa funcao propria para mostrar no ecra, em vez de estar aqui perdido 
  text("Score: "+score, m.i.posX, height/8);
  if (p1.b1.get(p1.level).enemycheck()) score++;
  if (score == 10 && e1.get(p1.level).health < 10) {
    p1.level = 1;
    hits = e1.get(p1.level).health/p1.dmg;
  }
  if (score == 20 && e1.get(p1.level).health < 10) {
    p1.level = 2;
    hits = e1.get(p1.level).health/p1.dmg;
  }
}
void mousePressed() { // quando clicar no botao do rato dentro das condicoes especificadas(dentro dos limites da imagem do botao)
  if(m.start.press()) m.start.pressed = true;
  if(m.exit.press()) m.exit.pressed = true;
  if(m.back.press()) m.back.pressed = true;
  if(m.instructionsbttn.press()) m.instructionsbttn.pressed = true;
  if(m.i.back.press()) m.i.back.pressed = true;
  if(m.highscorebttn.press()) m.highscorebttn.pressed = true;
  if(m.highscore.back.press()) m.highscore.back.pressed = true;
}