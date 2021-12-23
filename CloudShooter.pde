// Importar tudo da library GCP
import org.gamecontrolplus.*;
import net.java.games.input.*;

//inicializar objetos
ControlIO control; //objeto para ler controlos
Configuration config; //usar configuração
ControlDevice gpad; //usar dispositivo
Menu m;
CloudsGen c1;
CloudsGen c2;
CloudsGen c3;
Player p1;
Bullets b1;
Enemy e1;
public int score = 0;
public int lives = 3;
float bgc = 0;

//codigo apenas corrido 1x (inicio do programa)
void setup() {  
//https://forum.processing.org/one/topic/dynamic-screen-background-resize-need-guidance.html
//vou provavelmente precisar do link acima para colocar o tamanho da imagem de fundo dinamica 

  size(1920,1080,P2D); //utilizado para por o canvas em full screen

  //rectMode(CENTER); //função usada para centrar os rectângulos

  frameRate(60); //especificar framerate a usar
  //put a name on the window
  surface.setTitle("CloudShooter by Catarina & Claudio"); //titulo da janela
  // // Initialise the ControlIO
  // control = ControlIO.getInstance(this);
  // // Find a gamepad that matches the configuration file. To match with any 
  // // connected device remove the call to filter.
  // gpad = control.filter(GCP.GAMEPAD).getMatchedDevice("BController"); // necessario importar as duas configuracoes (bluetooth+cabo)
  // if (gpad == null) {
  //   println("No suitable device configured");
  //   exit(); // End the program NOW!
  // }

  m = new Menu(width/2, height/2);
  //nuvem 1
  c1 = new CloudsGen("/assets/images/cloud1.png", 100, random(height));
  //nuvem 2
  c2 = new CloudsGen("/assets/images/cloud2.png", 200, random(height));
  //nuvem 3
  c3 = new CloudsGen("/assets/images/cloud3.png", 300, random(height));
  //player 1
  p1 = new Player("/assets/images/first_ship_cs.png", 0, 0, 20);
  //bullet 1
  b1 = new Bullets("/assets/images/bullet.png", -650, -650/2, 100);
  //enemy 1
  e1 = new Enemy("/assets/images/ovni.png", (width - 300), (height - 300), 150, 5, 100);

}

//desenhar os elementos do programa no ecra
void draw() {
  //calls menu 
  //testing dynamic background color
  if(bgc < 256) background(bgc++, 0, 0, 0);
  else background(bgc--, 0, 0, 0);

  //quero adicionar um background que vai mudando a HUE de modo a ser dia/noite.
  m.start();
  if (m.state) {
    m.start.drawme(); //use loadtable to load the previous highscores
    m.exit.drawme();
    m.highscorestable.drawme();
    m.instructions.drawme();
  } //add a button to acess the highscores // add a button to acess instructions
  //stop the game with sleep() if the player dies and write GAME OVER, and if the play again is pressed you can resume.
  if(m.state == false){
    //claudio fez esta parte do codigo
    background(0, 80, 255); //background azul temporario
    m.back.drawme(); //desenhar o botão de pausa
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
    score(); //"b1.enemycheck();" ou seja: verificar se a bala atingiu o inimigo e acrescentar valor ao score
    
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

//acrescentar pontuacao na tabela
void score() {
  if (b1.enemycheck()) {
    score++;
  }
}

void mousePressed() { // quando clicar no botao do rato dentro das condicoes especificadas(dentro dos limites do "canvas" da imagem do botao), iniciar jogo ou sair do jogo
  if(m.start.press()) m.start.button = loadImage("assets/images/pressed_start_button.png");
  if(m.exit.press()) m.exit.button = loadImage("assets/images/pressed_exit_button.png");
  if(m.back.press()) m.back.button = loadImage("assets/images/pressed_back_button.png");
}

void mouseReleased() {
  if(m.start.press()) {
    m.start.pressed = true;
    m.start.button = loadImage("assets/images/start_button.png");
  }
  //println(m.start.pressed);
  if(m.exit.press()) {
    m.exit.pressed = true;
    m.exit.button = loadImage("assets/images/exit_button.png");
  }
  //println(m.exit.pressed);
  if(m.back.press()) {
    m.back.pressed = true;
    m.back.button = loadImage("assets/images/back_button.png");
  }
  //println("state butao back "+m.back.pressed);//debug
  //println("state menu "+m.state);//debug
}
