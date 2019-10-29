void polygon(float radius,int sides, float strokeWt, color fillCol) {
  float theta=0;
  float rotAmount = TWO_PI/sides;
  float x2,y2;
  strokeWeight(3);
  fill(fillCol);
  beginShape();
  for(int i=0 ; i < sides;i+=1){
    x2 = x + cos(theta)*radius ;
    y2 = y + sin(theta)*radius ;
    vertex(x2,y2);
    theta += rotAmount; 
  }
   endShape(CLOSE);
}
