class EdgeDemoObj extends EdgeObj {
  
  
  public EdgeDemoObj(String nodeLeftId, String nodeRightId,float count){
    super(nodeLeftId,  nodeRightId, count);
    
  }
  public String type(){return("Demotion Edge");};
  
  
   protected void drawEdgeShape() {
   pushMatrix();
    // translate(topL.x,topL.y);
     //scale(binW,binH);
     fill(215,25,28,100);
     noStroke();
     drawBox(topL,topR,bottomR,bottomL);
    
    popMatrix();
    }
  protected void drawEdgeText(float w, float h) {
    fill(215,25,28,255);
    printText("Demotions:" + (int)count,0,0,w,h,"C");
  }

}
   
