abstract class NodeObj {
    protected float year;
    protected float count;
    protected float startCount;
    protected float boxX, boxY,boxW,boxH;
    protected float binH;
    protected float maxCount;
    protected int lastBin;
    
    public NodeObj(float year){
      this.count = 0;
      this.year=year;;
   }
   
   public void add(float addCount){     count=count + addCount;
   }
   
   public void setStartCount(float startCount){
     this.startCount = startCount;
   }
   
   public float getCount(){return(count);};
   public float getStartCount(){return(startCount);};
  
   public float getYear(){return(year);};
 
   
   protected void calcNode(float minX, float maxX,float maxCount,PVector topLeft, PVector bottomRight)
   {
     float binW = (bottomRight.x-topLeft.x) / (maxX - minX+1)   ;
     binH = (bottomRight.y-topLeft.y) ;
     boxX = topLeft.x + binW*(year-minX);
     boxY = topLeft.y  + binH / maxCount * startCount ;
     boxW = binW*.2;
     boxH = binH / maxCount * count - binH*.02;
     this.maxCount = maxCount;
     if(year == maxX){lastBin = 1;} else {lastBin=0;}
     
   }
   
   public float getBoxX(){return(boxX);}
   public float getBoxY(){return(boxY);}
   public float getBoxW(){return(boxW);}
   public float getBoxH(){return(boxH);}
   public float getBinH(){return(binH);}
   public float getMaxCount(){return(maxCount);}
   public float getType(){return(maxCount);}
   
  protected abstract void drawNode();
 
}
