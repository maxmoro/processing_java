float x, y;
float radius;
float spdX, spdY;



void setup() {
  size(600, 600);
  x = width/2;
  y = 20;
  radius = 15;
  spdX = 1.3;
  spdY = 3.2;
}

void draw() {
  background(255);
  drawPoly();
  moveParticle();
  checkCollisions();
}

void drawPoly() {
  ellipse(x, y, radius*2, radius*2);
}

void moveParticle() {
  x += spdX;
  y += spdY;
}

void checkCollisions(){
}

