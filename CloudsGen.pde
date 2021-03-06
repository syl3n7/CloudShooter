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
  void drawme() {
    image(img, posX, posY); //function image to draw the image with three specified parameters inside
    move(); //calling the method move
    if (!m.state) reset(); //calling the method reset
  }
//method used to make the object run through X and randomly change height
  void move() {
    if (posX > -img.width) {
      posX -= random(2, 25); // acrescentar codigo noise
    } else {
      posX = width;
      posY = random(height);
    }
  }
  void reset() {//reset da posicao X e Y das nuvens quando o menu esta ativo
    posX = width; 
    posY = height;
  }
}