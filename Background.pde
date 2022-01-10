class Background {
//propriedades
    float posX, posY;
    PImage img;
//construtor
    Background(String n, float x, float y) {
        img = loadImage(n);
        posX = x;
        posY = y;
    }
//metodo desenhar para o canvas
    void drawme() {
        image(img, posX, posY);
    }
}