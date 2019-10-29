
class NodePromoObj extends NodeObj {
  
  public NodePromoObj(float x){
    super(x);
     
  }
  protected void drawNode()
 {   
   pushMatrix();
     translate(boxX,boxY);
     fill(26,150,65,150+100*lastBin);
     stroke(26,150,65);
     rect(0,0,boxW,boxH);
     rotate(PI/2);
     fill(255);
     printText("Promoted " + (int)count,0,-boxW/2,boxH,boxW*.7,"C");
   popMatrix();
   
      fill(8,48,107,150+100*lastBin);
     printText("Year:" + (int)year,boxX,boxY-binH*.02,boxW*3,binH*.05,"L");
   
 }
}
   
