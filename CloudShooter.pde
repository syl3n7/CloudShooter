// Importar tudo da library GCP
import org.gamecontrolplus.*;
import processing.video.*;

//inicializar objetos
ControlIO controlIO; //usar controlador
Menu m;
CloudsGen c1;
CloudsGen c2;
CloudsGen c3;
Player p1;
Bullets b1;
Enemy e1;
public int score = 0;
public int lives = 3;

//codigo apenas corrido 1x (inicio do programa)
void setup() {  

  fullScreen(P2D); //utilizado para por o canvas em full screen

  rectMode(CENTER); //função usada para centrar os rectângulos

  frameRate(30); //especificar framerate a usar

  //menu start
  m = new Menu(width/2, height/2);
  //nuvem 1
  c1 = new CloudsGen("/assets/images/cloud1.png", 100, random(height));
  //nuvem 2
  c2 = new CloudsGen("/assets/images/cloud2.png", 200, random(height));
  //nuvem 3
  c3 = new CloudsGen("/assets/images/cloud3.png", 300, random(height));
  //player 1
  p1 = new Player("/assets/images/f16.png", 0, 0, 20);
  //bullet 1
  b1 = new Bullets("/assets/images/bullet.png", -650, -650/2, 100);
  //enemy 1
  e1 = new Enemy("/assets/images/ovni.png", (width - 300), (height - 300), 150, 5, 100);

}

//quero adicionar um background que vai mudando a HUE de modo a ser dia/noite.

//desenhar os elementos do programa no ecra
void draw() {
  //calls menu
  background(0);
  m.start();
  if (m.state) {
    m.button1.drawme();
    m.button2.drawme();
  }

  if(m.state == false){
    //claudio fez esta parte do codigo
    background(0, 80, 255); //background azul temporario
    c1.drawme(); //desenhar nuvem1
    c2.drawme(); //desenhar nuvem2
    c3.drawme(); //desenhar nuvem3
    c1.move(); //mover a nuvem1
    c2.move(); //mover a nuvem2
    c3.move(); //mover a nuvem3
    p1.drawme(); //desenhar o player1
    p1.moveme(); //mover o player1
    b1.drawme(); //desenhar as balas
    b1.moveme(); //mover as balas
    e1.drawme(); //desenhar o inimigo
    e1.move(); //Bmover o inimigo
    //  e1.healthcheck(); //verificar se o inimigo morreu ou nao
    score();
    b1.enemycheck(); //verificar se a bala atingiu o inimigo
  }
}

void keyPressed() {
  //falta por a bala a funcionar como no movimento smooth.
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

//codigo importado do exemplo do professor em ordem a obter movimento suave
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

//acrescentar pontuacao na tabela
void score() {
  if (b1.enemycheck()) {
    score++;
  }
}

void mousePressed() { // quando clicar no botao do rato dentro das condicoes especificadas(dentro dos limites do "canvas" da imagem do botao), iniciar jogo ou sair do jogo
  if(mouseX < m.button1.button.width && mouseX < m.button1.button.width && mouseY > m.button1.button.height && mouseY < m.button1.button.height){
    if(m.button1.pressed == false) m.button1.pressed = true;
  }
  if(mouseX < m.button2.button.width && mouseX < m.button2.button.width && mouseY < m.button2.button.height && mouseY < m.button2.button.height){
    if(m.button2.pressed == false) m.button2.pressed = true;
  }
}