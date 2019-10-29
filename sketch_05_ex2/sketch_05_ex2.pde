PImage img; 

void setup() {
  size(1050,1200);
  img = loadImage("img.png");
  background(0);
  image(img,0,0);
  img.loadPixels();
  int p;
  for(int i=0;i<(img.width * img.height);i++){
    p = img.pixels[i];
    img.pixels[i]=color(255-red(p),255-green(p),255,blue(p));
  }
  img.updatePixels();
  image(img,0,0);
}
