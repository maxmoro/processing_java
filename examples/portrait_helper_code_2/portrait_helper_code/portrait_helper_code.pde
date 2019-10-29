PImage img;

void setup() {
  
  img = loadImage("gray_head.jpeg");
  img.resize(int(img.width*.5), int(img.height*.5));
  println(img.width,img.height);
  /*size(img.width, img.height);*/ 
  size(626,626);
  
  background(img);

  fill(230, 142, 85);
  noStroke();
  beginShape();
  curveVertex(193, 425);
  curveVertex(192, 181);
  curveVertex(419, 164);
  curveVertex(365, 480);
  curveVertex(193, 425);
  curveVertex(192, 181);
  endShape(CLOSE);
}

// runs 60 x per second
void draw() {
}
//
void mousePressed() {
  println(mouseX +", "+mouseY);
}
