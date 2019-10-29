class EdgeSepObj extends EdgeObj {
  
  
  public EdgeSepObj(String nodeLeftId, String nodeRightId,float count){
    super(nodeLeftId,  nodeRightId, count);
      }
      
  public String type(){return("Separation Edge");};
  
   protected void drawEdgeShape() {
   pushMatrix();
    
     fill(64,64,64,100);
     noStroke();
     drawBox(topL,topR,bottomR,bottomL);
    
    popMatrix();
    }
  protected void drawEdgeText(float w, float h) {
     
    fill(64,64,64,255);
    
      printText("Separations:" + (int)count,0,0,w,h,"C");
    
     
   
 }
}
   
