class NodeSameObj extends NodeObj {
  
  public NodeSameObj(float x){
    super(x);
     
  }
    
  protected void drawNode() {   
   pushMatrix();
     translate(boxX,boxY);
     
     fill(8,48,107,150+100*lastBin);
     stroke(8,48,107);
     rect(0,0,boxW,boxH);
     rotate(PI/2);
     fill(255);
     printText("No change " + (int)count,0,-boxW/2,boxH,boxW*.7,"C");
   popMatrix();
 }
}
