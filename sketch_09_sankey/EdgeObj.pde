abstract class EdgeObj {
    protected PVector pos;
    protected float startCountL;
    protected float startCountR;
    protected float hL,hR;
    
    
    protected float count;
    protected String nLid;
    protected String nRid;
    protected PVector topL;
    protected PVector topR;
    protected PVector bottomL;
    protected PVector bottomR;
    protected int isAChange;
    
    public EdgeObj(String nodeLeftId, String nodeRightId,float count){
      this.pos = new PVector(0,0);
       
            
      this.nLid = nodeLeftId;
      this.nRid = nodeRightId; 
      this.count = count;
   }
   
   public String type(){return("Generic Edge");};
   
   public void setStartCountL(float startCountL){this.startCountL = startCountL;}
   public void setStartCountR(float startCountR){this.startCountR= startCountR;}
     
   public String getNLid(){return(nLid);}
   public String getNRid(){return(nRid);}
   public float getCount(){return(count);}
   
   protected void calcEdge(HashMap nodes )
   {
     
     NodeObj nL, nR;
     nL = (NodeObj)nodes.get(nLid);
     nR = (NodeObj)nodes.get(nRid);
     hL = nL.getBoxH() / nL.getCount() * count;
     hR = nR.getBoxH() / nR.getCount() * count;
     float sL = nL.getBoxH() / nL.getCount() * startCountL;
     float sR = nR.getBoxH() / nR.getCount() * startCountR;
     topL = new PVector(nL.getBoxX() + nL.getBoxW(), nL.getBoxY() + sL);
     topR = new PVector(nR.getBoxX(), nR.getBoxY() + sR);
     bottomL = new PVector(topL.x  , topL.y + hL);
     bottomR = new PVector(topR.x  , topR.y + hR);
     isAChange=1;
     if(nL instanceof NodePromoObj && nR instanceof  NodePromoObj) isAChange=0;
     if(nL instanceof NodeDemoObj && nR instanceof  NodeDemoObj) isAChange=0;
     if(nL instanceof NodeSameObj && nR instanceof  NodeSameObj) isAChange=0;
     if(nL instanceof NodeSepObj && nR instanceof  NodeSepObj) isAChange=0;
   }
   
    public void drawEdge(){
       drawEdgeShape();
       if(count > 1 &&  isAChange==1){
          float w = abs(bottomR.x-bottomL.x)*.8;
          float h = abs(hR) ;
          if(h<height*.01) h=height*.01;

         pushMatrix();
          translate(topL.x,topL.y);
          rotate(atan((topR.y - topL.y)/(topR.x - topL.x)));
          translate(abs(bottomR.y-bottomL.y)/3,0);
          drawEdgeText(w,h);
          popMatrix();
       }
    
   }
   
    protected abstract void drawEdgeText(float w, float h);
    protected abstract void drawEdgeShape();
 
}
