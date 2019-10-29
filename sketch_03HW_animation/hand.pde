public void drawHand(float radius) {
     
    beginShape();
      vertex(-radius/10,-radius/10);
      vertex(-radius/10,-radius/10);
      vertex(0,0);
      vertex(-radius/10,radius/10);
      vertex(radius,0);
      vertex(-radius/10,-radius/10);
      vertex(-radius/10,-radius/10);
    endShape();
 
}
