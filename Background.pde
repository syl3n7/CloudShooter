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
        if(p1.health < 25){
            img.loadPixels();
            for(int x = 0; x < width; x++) {
                for(int y = 0; y < height; y++) {
                    if(blue(img.pixels[x+y*img.width]) > 128) {
                        img.pixels[x+y*img.width] = color(128, 0, 0);
                    }
                }
            }
            img.updatePixels();
        }
        image(img, posX, posY);
    }
}