class EdgePromoObj extends EdgeObj {
  
  
  public EdgePromoObj(String nodeLeftId, String nodeRightId,float count){
    super(nodeLeftId,  nodeRightId, count);
      }
  
  public String type(){return("Promo Edge");};
  
  protected void drawEdgeShape() {
   
     fill(26,150,65,100);
     noStroke();
     drawBox(topL,topR,bottomR,bottomL);
   
  }
  protected void drawEdgeText(float w, float h) {
      
     fill(26,150,65,255);
      printText("Promotions:" + (int)count,0,0,w,h,"C");
     
  }
   
 
   
}
   
