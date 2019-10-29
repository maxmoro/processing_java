
class NodeDemoObj extends NodeObj {
  
  public NodeDemoObj(float x){
    super(x);
     
  }
    
  protected void drawNode() {   
   pushMatrix();
     translate(boxX,boxY);
     fill(215,25,28,150+100*lastBin);
     stroke(215,25,28);
     rect(0,0,boxW,boxH);
     rotate(PI/2);
     fill(255);
     String txt="Demoted " + (int)count;
     if (count < maxCount*.08){txt = "D " + (int)count;}
     printText(txt,0,-boxW/2,boxH,boxW*.7,"C");
   popMatrix();
   
   
 }
 
}
