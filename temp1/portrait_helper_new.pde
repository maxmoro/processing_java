int p2y = 150;
int p3x = 350;
int p3y = 350;
void setup()
{
  size(500, 500);
}
void draw()
{
  strokeWeight(1);
  fill(255, 255, 255);
  rect(100, 100, 300, 300);
  
  fill(255, 255, 0);
  strokeWeight(10);
  beginShape();
    curveVertex(p0x, p0y);
    curveVertex(p0x, p0y);
    curveVertex(p1x, p1y);
    curveVertex(p2x, p2y);
    curveVertex(p3x, p3y);
    curveVertex(p3x, p3y);
  endShape(CLOSE);
  
  strokeWeight(1);
  fill(255, 0, 0);
  ellipse(p0x, p0y, 10, 10);
  ellipse(p1x, p1y, 10, 10);
  ellipse(p2x, p2y, 10, 10);
  ellipse(p3x, p3y, 10, 10);
}
