import java.awt.*;

//inicializar objetos
Menu m;
CloudsGen c1;
CloudsGen c2;
CloudsGen c3;
PlayerShipMenu pm;
Player p1;
Bullets b1;
Enemy e1;
public int score = 0;
public int lives = 3;
float bgc = 0;
int center_x, center_y;
boolean bgcUpperLimit = false;

//codigo apenas corrido 1x (inicio do programa)
void setup() {  
//https://forum.processing.org/one/topic/dynamic-screen-background-resize-need-guidance.html
//vou provavelmente precisar do link acima para colocar o tamanho da imagem de fundo dinamica 

//dinamic window size begin (without borders)
  fullScreen(P2D);
  Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
  int screenWidth = screenSize.width;
  int screenHeight = screenSize.height;
  surface.setSize(screenWidth, screenHeight);
  smooth(4);
  center_x = screenWidth/2-width/2;
  center_y = screenHeight/2-height/2;
  surface.setLocation(center_x, center_y); //set location of canvas to center of screen resolution
//dinamic window size end

  //rectMode(CENTER); //função usada para centrar os rectângulos
  frameRate(60); //especificar framerate a usar
  surface.setTitle("CloudShooter by Catarina & Claudio"); //titulo da janela

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
  p1 = new Player("/assets/images/first_ship_cs.png", 0, 0, 20);
  //bullet 1
  b1 = new Bullets("/assets/images/bullet.png", -650, -650/2, 100);
  //enemy 1
  e1 = new Enemy("/assets/images/ovni.png", (width - 300), (height - 300), 150, 5, 100);
}

//desenhar os elementos do programa no ecra
void draw() {
   
  //testing dynamic background color
  if (bgc == 250) bgcUpperLimit = true;
  if (bgcUpperLimit == false) background(bgc++, 0, bgc, 0); //se parar de dar update ao background, funciona como um botao de pausa, maybe later ?
  if (bgc == 5) bgcUpperLimit = false; 
  if (bgcUpperLimit == true) background(bgc--, 0, bgc, 0);

  //calls menu
  m.start();
  if (m.state) {
    if(pm.state == false) {
      m.start.drawme(); //use loadtable to load the previous highscores
      m.exit.drawme();
      m.highscorestable.drawme();
      m.instructions.drawme();
    }
    pm.drawme();
  } //add a button to acess the highscores // add a button to acess instructions
  
  if(m.state == false){
    //claudio fez esta parte do codigo
    //quero adicionar um background que vai mudando a HUE de modo a ser dia/noite.
    //testing dynamic background color
    if (bgc == 250) bgcUpperLimit = true;
    if (bgcUpperLimit == false) background(0, 20, bgc++, 0); //se parar de dar update ao background, funciona como um botao de pausa, maybe later ?
    if (bgc == 25) bgcUpperLimit = false; 
    if (bgcUpperLimit == true) background(0, 20, bgc--, 0);
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

//acrescentar pontuacao na tabela
void score() {
  if (b1.enemycheck()) {
    score++;
  }
}

void mousePressed() { // quando clicar no botao do rato dentro das condicoes especificadas(dentro dos limites do "canvas" da imagem do botao), iniciar jogo ou sair do jogo
  if(m.start.press()) m.start.pressed = true; //m.start.button = loadImage("assets/images/pressed_start_button.png");
  if(m.exit.press()) m.exit.pressed = true; //m.exit.button = loadImage("assets/images/pressed_exit_button.png");
  if(m.back.press()) m.back.pressed = true; //m.back.button = loadImage("assets/images/pressed_back_button.png");
}

/*void mouseReleased() {
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
}*/
