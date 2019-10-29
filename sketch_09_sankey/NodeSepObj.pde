


class NodeSepObj extends NodeObj {
  
  public NodeSepObj(float x){
    super(x);
     
  }
  
     
  protected void drawNode() {   
   pushMatrix();
     translate(boxX,boxY);
     
     fill(64,64,64,150+100*lastBin);
     stroke(64,64,64);
     rect(0,0,boxW,boxH);
     rotate(PI/2);
     fill(255);
     printText("Separated " + (int)count,0,-boxW/2,boxH,boxW*.7,"C");
   popMatrix();
 }
    
}
