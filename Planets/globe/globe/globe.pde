PImage earth;
PShape globe;

//______________________________________ SETUP
void setup() {
  size(640, 360, P3D);
  earth = loadImage("earth.jpg");
  globe = createShape(SPHERE, 1);
  globe.setStroke(false);
  globe.setTexture(earth);
  info_print();
}

void draw_object() { //_________________called by / from inside PTZ
  noStroke();        //directionalLight(250, 250, 250, 0, 0, -1); //ambientLight(100,100,100); // light and texture not work together
  shape(globe,0, 0);
}

//______________________________________ DRAW
void draw() {
  background(0, 0, 50);
  PTZ();
}
