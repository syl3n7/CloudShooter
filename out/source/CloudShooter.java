
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import org.gamecontrolplus.*;
import net.java.games.input.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class CloudShooter extends PApplet {

// Importar tudo da library GCP



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
 public void setup() {  
//https://forum.processing.org/one/topic/dynamic-screen-background-resize-need-guidance.html
//vou provavelmente precisar do link acima para colocar o tamanho da imagem de fundo dinamica 

  /* size commented out by preprocessor */; //utilizado para por o canvas em full screen

  //rectMode(CENTER); //função usada para centrar os rectângulos

  frameRate(60); //especificar framerate a usar
  //put a name on the window
  surface.setTitle("CloudShooter by Catarina & Claudio"); //titulo da janela
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a gamepad that matches the configuration file. To match with any 
  // connected device remove the call to filter.
  gpad = control.filter(GCP.GAMEPAD).getMatchedDevice("BController"); // necessario importar as duas configuracoes (bluetooth+cabo)
  if (gpad == null) {
    println("No suitable device configured");
    exit(); // End the program NOW!
  }

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

//desenhar os elementos do programa no ecra
 public void draw() {
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

 public void keyPressed() {
  if (key == ' ') {
    p1.shoot();
  }

  if(key == 's'|| key == 'S') p1.moveDown = true;
  if(key == 'w'|| key == 'W') p1.moveUp = true;
  if(key == 'a'|| key == 'A') p1.moveLeft = true;
  if(key == 'd'|| key == 'D') p1.moveRight = true;
}

 public void keyReleased() {
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
 public void score() {
  if (b1.enemycheck()) {
    score++;
  }
}

 public void mousePressed() { // quando clicar no botao do rato dentro das condicoes especificadas(dentro dos limites do "canvas" da imagem do botao), iniciar jogo ou sair do jogo
  if(m.start.pressed()) m.start.button = loadImage("assets/images/pressed_start_button.png");
  if(m.exit.pressed()) m.exit.button = loadImage("assets/images/pressed_exit_button.png");
  if(m.back.pressed()) m.back.button = loadImage("assets/images/pressed_back_button.png");
}

 public void mouseReleased() {
  if(m.start.pressed()) m.start.pressed = true;
  if(m.start.pressed()) m.start.button = loadImage("assets/images/start_button.png");
  //println(m.start.pressed);
  if(m.exit.pressed()) m.exit.pressed = true;
  if(m.exit.pressed()) m.exit.button = loadImage("assets/images/exit_button.png");
  //println(m.exit.pressed);
  if(m.back.pressed()) m.back.pressed = true;
  if(m.back.pressed()) m.back.button = loadImage("assets/images/back_button.png");
  //println("state butao back "+m.back.pressed);//debug
  //println("state menu "+m.state);//debug
}
class Bullets {

  //propriedades
  PImage bullet;
  float posX, posY, tam;

  //construtor
  Bullets(String name, float x, float y, float t) {
    bullet = loadImage(name);
    posX = x;
    posY = y;
    tam = t;
  }

  //desenhar as balas no ecra
   public void drawme() {
    //redimensionar a imagem da bala para o tamanho pretendido
    bullet.resize(PApplet.parseInt(tam), 25);
    //desenhar imagem da bala no canvas
    image(bullet, posX, posY);
  }

  //mover a bullet a partir da posicao do player
   public void moveme() {
    //Para a bala precorrer o Y desde o ponto de spawn ate ao final do Y do canvas
    if (posY < width-tam) {
      posX += tam;
    }
  }
  //verificar se a posicao X e Y do enimigo, corresponde a mesma posicao X e Y da bala, em ordem a contar como HIT
   public boolean enemycheck(){
    if (dist(b1.posX+b1.tam/2, b1.posY+b1.tam/2, e1.posX+e1.tam/2, e1.posY+e1.tam/2) < tam) {
      return true;
    }
    return false;
  }
}
class Button{

//properties
PImage button;
float posX, posY, tam1, tam2;
boolean pressed;

    Button(String name, float x, float y){
        button = loadImage(name);
        //button.resize(button.width/2, button.height/2);
        tam1 = 210;
        tam2 = 130;
        posX = x;
        posY = y;
        pressed = false;
    }

     public void drawme(){
        image(button, posX, posY);//colocar isto na liunha 21 depois
        fill(255, 0, 0, 100); //manual debug
        rect(posX+60, posY+60, tam1, tam2); //manual debug
    }

//i want to use this so that i dont mess with the variable outside of the class
     public boolean pressed(){
        if(mouseX > posX && mouseX < posX + tam1 && mouseY > posY && mouseY < posY + tam2*2 ){
            pressed = true;
        }
        return pressed;
    }
}
//creating the class for cloud generating
class CloudsGen {

//properties
  PImage img; //declaring varible to save images
  float posX, posY; //positions X and Y on canvas

//constructor
  CloudsGen(String nome, float x, float y) {
    img = loadImage(nome); //inicializing the variable, with the value passed through the CloudShooter.pde values.
    posX = x;
    posY = y;
  }

//method used to draw the objects on the canvas
   public void drawme() {
    image(img, posX, posY); //function image to draw the image with three specified parameters inside
  }

//method used to make the object run through X and randomly change height
   public void move() {
    if (posX > -img.width) {
      posX -= random(2, 25); // acrescentar codigo noise
    } else {
      posX = width;
      posY = random(height);
    }
  }
}
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
//necessito de chamar recursivamente esta funcao para que o jogador possa eliminar o inimigo e ele continue a dar spawn
   public void drawme() {
    img.resize(PApplet.parseInt(tam), PApplet.parseInt(tam)); //redimensiona a imagem
    image(img, posX, posY);
  }

//necessito de fazer com que o enimigo se multiplique a cada posY completo 

//fazer enimigo andar pelo canvas variando velocidade horizontal e posicao vertical aleatoria
   public void move() {
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
      trand += 0.07f;
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
class Highscore{

//propriedades
Table table;

//construtor
    Highscore(){
        //inicializar a tabela para armazenar highscore
        table = new Table();
        //adicionar colunas na tabela
        table.addColumn("id");
        table.addColumn("score");
    }

     public void addData(){
        TableRow newRow = table.addRow();
        //adicionar linhas na tabela
        newRow.setInt("id", table.lastRowIndex()+1);
        newRow.setInt("score", score);
    }

     public void saveData(){
        //guardar os dados da tabela no ficheiro
        saveTable(table, "data/highscore.csv");
    }

    //metodos
     public int top5(){ // tenho que por isto a funcionar para mostrar pelo botao highscore
        int result = 0;
        //ler o ficheiro e determinar o top 5
        
        return result;
    }

}
class Menu{

//propriedades
float posX, posY;
boolean state;
Button start, exit, back, highscorestable, instructions, credits;
Highscore highscore;

    //construtor 
    Menu(float x, float y) {
        posX = x;
        posY = y;
        state = true;
        start = new Button("assets/images/start_button.png", width/2 - 500, height/2 - 100); //image to be changed in the near future
        exit = new Button("assets/images/exit_button.png", width/2 + 100, height/2 - 100);
        back = new Button("assets/images/exit_button.png", 1600, 10);
        instructions = new Button("assets/images/instructions_button.png", width/2 - 500, height/2 + 200);
        highscorestable = new Button("assets/images/highscores_button.png", width/2 + 100, height/2 + 200);
        highscore = new Highscore();
    }

    //método usado para desenhar os botões
     public void start() {
        //verficar estado pressed de cada botao
        if(state){
            if (start.pressed) state = false;
            if (exit.pressed) { ///pressionar botao exit guarda highscore e sai do jogo
                highscore.saveData();
                exit();
            } 
        }
        if(back.pressed) {
            highscore.addData();
            state = true;
            start.pressed = false;
            back.pressed = false;
        }
    }
} 
class Player {
  //Properties
  float altura, largura; //altura e largura da imagem
  PImage img; //sprite normal
  //PImage img2; //sprite while moving up
  //PImage img3; //sprite while moving down
  float posX, posY, tam, health;
  boolean moveUp, moveDown, moveLeft, moveRight; //booleanas para controlar o movimento do player

  //Constructor
  Player(String n, float x, float y, float t) {
    img = loadImage(n);
    //imgUp = loadimage(imgUp);
    //imgDown = loadimage(imgDown);
    //imgLeft = loadimage(imgLeft);
    //imgRight = loadimage(imgRight);
    posX = x;
    posY = y;
    tam = t;
    health = 100;
    largura = img.width;
    altura = img.height;
    moveDown  = false;
    moveLeft  = false;
    moveRight = false;
    moveUp = false;  
  }

  //spawn da imagem mediante parametros indicados + resize para tamanho pretendido
   public void drawme() {
    img.resize(650, 350);
    if(health > 0) {
      image(img, posX, posY); //missing the new sprite
    }
    checkDirection();
  }

  //check direction and change the sprite acordingly
   public void checkDirection() {
    if(moveUp) {
      //img = loadImage(imgUp); //missing the sprite
    }
    if(moveDown) {
      //img = loadImage(imgDown); //missing the sprite
    }
    if(moveLeft) {
      //img = loadImage(imgLeft); //missing the sprite
    }
    if(moveRight) {
      //img = loadImage(imgRight); //missing the sprite
    } 
  }

  //damage radius
   public void damage() {
    //http://jeffreythompson.org/collision-detection/rect-rect.php
    //ler novamente o link acima. necessito de fazer a verificacao de colisao.
  }

   public void shoot () {  
    b1.posX = posX+largura/2.5f;
    b1.posY = posY+altura/3.4f;
    b1.moveme();
  }

  //validar posicao e incremento da mesma caso tecla seja pressionada
   public void moveme(){
    if (moveLeft) posX -= tam;  // "if(left == true)" igual a "if(left)"
    else if (moveRight) posX += tam;
    else if (moveUp) posY -= tam;
    else if (moveDown) posY += tam;
  }
  
  //codigo importado do exemplo do professor em ordem a obter movimento + suave
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


  public void settings() { size(1920, 1080, P2D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CloudShooter" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
