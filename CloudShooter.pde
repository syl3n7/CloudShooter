import java.awt.*;//importar libraria grafica
//declarar objetos
Menu m;
boolean displayGame = false;
CloudsGen c1;
CloudsGen c2;
CloudsGen c3;
PlayerShipMenu pm;
public Player p1;
public ArrayList<Enemy> e1; //tornar isto num array em condicoes
public int score = 0;
public int lives = 3;
public int center_x, center_y;
//codigo apenas corrido 1x (inicio do programa)
void setup() {
//https://forum.processing.org/one/topic/dynamic-screen-background-resize-need-guidance.html
//dinamic window size begin (without borders)
  surface.setTitle("CloudShooter by Catarina & Claudio"); //titulo da janela
  fullScreen(0,P2D); //fullscreen
  frameRate(60); //especificar framerate a usar
  Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize(); //ir buscar a dimensao da tela
  int screenWidth = screenSize.width; //ir buscar a largura da tela
  int screenHeight = screenSize.height; //ir buscar a largura da tela
  surface.setSize(1920, 1080/*screenWidth, screenHeight*/);
  smooth(8);//funcao de antialiasing
  center_x = screenWidth/2-width/2; //ir buscar o meio do eixo X
  center_y = screenHeight/2-height/2; //ir buscar o meio do eixo Y
  surface.setLocation(center_x, center_y); //set location of canvas to center of screen resolution
  imageMode(CENTER); //funcao para centrar o spawn de imagens
  rectMode(CENTER); //função para centrar o spawn de rectângulos
  //ellipseMode(CENTER);//funcao para centrar o spawn de elipses
  textAlign(CENTER);
  noStroke();
  /*Inicializar Objetos ⬇️*/
  //menu
  m = new Menu(width/2, height/2);
  //menu para escolha de "nave" usa bala e imagem diferente
  pm = new PlayerShipMenu(width/2, height/2);
  //nuvem 1
  c1 = new CloudsGen("/assets/images/cloud1.png", 100, random(height));
  //nuvem 2
  c2 = new CloudsGen("/assets/images/cloud2.png", 200, random(height));
  //nuvem 3
  c3 = new CloudsGen("/assets/images/cloud3.png", 300, random(height));
  //player 1
  p1 = new Player("/assets/images/first_ship_cs.png", -200, height/2);//spawn fora do canvas para animar a entrada do player no jogo
  //enemy 1
  e1 = new ArrayList<Enemy>();
  e1.add(new Enemy("/assets/images/AlienSpaceship.png", (width - 300), (height - 300), 150, 5, 100));
  e1.add(new Enemy("/assets/images/AlienSpaceship_secondcs.png", (width - 300), (height - 300), 150, 5, 100));
  e1.add(new Enemy("/assets/images/AlienSpaceship_thirdcs.png", (width - 300), (height - 300), 150, 5, 100));
}
//desenhar os elementos do programa no ecra
void draw() {
  //calls menu
  m.start(); //verifica presses
  if (m.i.active) {
    m.i.drawme();
    m.i.back.drawme();
  } if (pm.state && score >= 25) {
    pm.drawme();
    pm.back.drawme();
    pm.ship1.drawme();
    pm.ship2.drawme();
    pm.ship3.drawme();
    }
  } if (m.highscore.active) {
    m.highscore.drawme();
    m.highscore.back.drawme();
  } if (m.state) {
    m.start.drawme(); //use loadtable to load the previous highscores
    m.exit.drawme();
    m.highscorebttn.drawme();
    m.instructionsbttn.drawme();
  } if (displayGame){
    //claudio fez esta parte do codigo
    m.background.drawme();
    m.back.drawme(); //desenhar o botão de pausa
    c1.drawme(); //desenhar e mover nuvem1
    c2.drawme(); //desenhar e mover nuvem2
    c3.drawme(); //desenhar e mover nuvem3
    p1.drawme(); //desenhar e mover o player1
    e1.get(p1.level).drawme(); //desenhar e mover o inimigo
    healthcheck(); //verificar vida do player, do inimigo
    score(); //calls"b1.enemycheck();" ou seja: verificar se a bala atingiu o inimigo e acrescentar valor ao score
  }
}
void keyPressed() {
  if (key == ' ') {
    p1.shoot();
  }
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
//codigo importado do exemplo fornecido pelo professor para o movimento ser + suave
/*void keyPressed() {
  if(key == 'j' || key == 'J') plane.left = true;
  if(key == 'l' || key == 'L') plane.right = true;
  if(key == 'i' || key == 'I') plane.up = true;
  if(key == 'k' || key == 'K') plane.down = true;
}
void keyReleased() {
  if(key == 'j' || key == 'J') plane.left = false;
  if(key == 'l' || key == 'L') plane.right = false;
  if(key == 'i' || key == 'I') plane.up = false;
  if(key == 'k' || key == 'K') plane.down = false;
}
*/
//verificar se o player colidiu com o inimigo
void healthcheck(){
  //put here code for checking between bullet and enemy
  // float distX = p1.posX - e1.get(p1.level).posX;
  // float distY = p1.posY - e1.get(p1.level).posY;
  // float distance = sqrt((distX*distX) + (distY*distY)); //(PI * (190/2) * (80/2)) + (PI * (150/2) * (70/2));
  // if (distance <= distX + distY) p1.health -= 10;//if distance is less than PI than the radius of the enemy, then the player loses health (10)
  // if (distance <= distX + distY) e1.health -= p1.b1.damage;
}
//acrescentar pontuacao na tabela
void score() {
  textSize(32);
  text("Score: "+score, m.i.posX, height/8);
  if (p1.b1.get(p1.level).enemycheck()) score++;
  if (score == 10 && e1.get(p1.level).health < 10) p1.level = 1;
  if (score == 20 && e1.get(p1.level).health < 10) p1.level = 2;
}
void mousePressed() { // quando clicar no botao do rato dentro das condicoes especificadas(dentro dos limites do "canvas" da imagem do botao), iniciar jogo ou sair do jogo
  if(m.start.press()) m.start.button = loadImage("assets/images/pressed_start_button.png");
  if(m.exit.press()) m.exit.button = loadImage("assets/images/pressed_exit_button.png");
  if(m.back.press()) m.back.button = loadImage("assets/images/pressed_back_button.png");
  if(m.instructionsbttn.press()) m.instructionsbttn.button = loadImage("assets/images/pressed_instructions_button.png");
  if(m.i.back.press()) m.i.back.button = loadImage("assets/images/pressed_back_button.png");
  if(m.highscorebttn.press()) m.highscorebttn.button = loadImage("assets/images/pressed_highscores_button.png");
  if(m.highscore.back.press()) m.highscore.back.button = loadImage("assets/images/pressed_back_button.png");
}
//nao vou mudar as sprites para pressed images por enquanto, talvez depois de resolver o resto do codigo.
void mouseReleased() {
  if(m.start.press()) m.start.pressed = true;
  if(m.exit.press()) m.exit.pressed = true;
  if(m.back.press()) m.back.pressed = true;
  if(m.instructionsbttn.press()) m.instructionsbttn.pressed = true;
  if(m.i.back.press()) m.i.back.pressed = true;
  if(m.highscorebttn.press()) m.highscorebttn.pressed = true;
  if(m.highscore.back.press()) m.highscore.back.pressed = true;
  //println("state butao back "+m.back.pressed);  //debug
  //println("state menu "+m.state); //debug
}