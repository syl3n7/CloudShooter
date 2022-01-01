class Bullets {

  //propriedades
  PImage bullet;
  float posX, posY, tam;

  //construtor
  Bullets(String n, float x, float y, float t) {
    bullet = loadImage(n);
    posX = x;
    posY = y;
    tam = t;
  }

  //desenhar as balas no ecra
  void drawme() {
    //redimensionar a imagem da bala para o tamanho pretendido
    bullet.resize(int(tam), 25);
    //desenhar imagem da bala no canvas
    image(bullet, posX, posY);
  }

  //mover a bullet a partir da posicao do player
  void moveme() {
    //Para a bala precorrer o Y desde o ponto de spawn ate ao final do Y do canvas
    if (posY < width-tam) {
      posX += tam;
    }
  }
  //verificar se a posicao X e Y do enimigo, corresponde a mesma posicao X e Y da bala, em ordem a contar como HIT
  public boolean enemycheck(){
    if (dist(posX+tam/2, posY+tam/2, e1.get(p1.level).posX+e1.get(p1.level).tam/2, e1.get(p1.level).posY+e1.get(p1.level).tam/2) < tam) {
      return true;
    }
    return false;
  }
}
