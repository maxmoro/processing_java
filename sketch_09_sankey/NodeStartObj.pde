
class NodeStartObj extends NodeObj {
  
  public NodeStartObj(float x){
    super(x);
     
  }
  protected void drawNode()
 {   
   pushMatrix();
     translate(boxX,boxY);
     fill(8,48,107);
     stroke(8,48,107);
     rect(0,0,boxW,boxH);
     rotate(PI/2);
     fill(255);
     printText("Starting Population " + (int)count,0,-boxW*.70,boxH,boxW*.9,"C");
   popMatrix();
   
   
     fill(8,48,107);
     printText("Year:" + (int)year,boxX,boxY-binH*.02,boxW*3,binH*.05,"L");
   
 }
 
 
}
   
