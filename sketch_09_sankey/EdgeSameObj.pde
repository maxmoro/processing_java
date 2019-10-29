class EdgeSameObj extends EdgeObj {
  
  
  public EdgeSameObj(String nodeLeftId, String nodeRightId,float count){
    super(nodeLeftId,  nodeRightId, count);
      }
  public String type(){return("NoChange Edge");};
  
  protected void drawEdgeShape() {
   pushMatrix();
    // translate(topL.x,topL.y);
     //scale(binW,binH);
     fill(8,81,156,100);
     noStroke();
     drawBox(topL,topR,bottomR,bottomL);
    
    popMatrix();
    }
  protected void drawEdgeText(float w, float h) {
    fill(8,81,156,255);
    printText("No Changes:" + (int)count,0,0,w,h,"C");
    
  }
}
   
