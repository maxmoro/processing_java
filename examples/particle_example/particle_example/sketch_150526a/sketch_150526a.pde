float x, y;
float radius;
float spdX, spdY;

void setup(){
  size(600, 600);
  x = width/2;
  y = 20.0;
  radius = 23.5;
  spdX = 1.2;
  spdY = 3.2;
}

void draw(){
  background(255);
  moveParticle();
  drawParticle();
  checkCollision();
}

void moveParticle(){
  x += spdX;
  y = y + spdY;
}

void drawParticle(){
  ellipse(x, y, radius*2, radius*2);
}

void checkCollision(){
  // check boundary collision
}
