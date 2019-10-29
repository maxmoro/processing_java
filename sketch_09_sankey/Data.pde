import java.util.Map;
class Data{
  protected ArrayList<EdgeObj> edges;
  protected HashMap<String, NodeObj> nodes;
  
  private Table table;
  private float minYear = 9999;
  private float maxYear = 0;
  private float maxCount = 0;
  
  public void read(String file){
    edges  = new ArrayList<EdgeObj>();
    nodes = new HashMap<String, NodeObj>();
    table = loadTable(file,"header");
    String nLid="";
    String nRid="";
    String task="";
    float yearLeft = 0;
    float yearRight = 0;
    EdgeObj  e = null;
    NodeObj  nL = null;
    NodeObj  nR = null;
    float count = 0;
    for (TableRow trow : table.rows()) {
      nLid = trow.getString("curr_node");
      nRid = trow.getString("next_node");
      count = trow.getFloat("count");
      task = trow.getString("action");
      yearLeft = trow.getFloat("year");
      yearRight = trow.getFloat("next_year");
      if(yearLeft < minYear) minYear = yearLeft;
      if(yearRight > maxYear) maxYear = yearRight;
      if(yearLeft == minYear) maxCount = maxCount + count;
      println(task);
      nL = nodes.get(nLid);
      nR = nodes.get(nRid);
      if(yearLeft==minYear && nL==null) nL = new NodeStartObj(yearLeft);
      switch (task) {
        case "Promotion":
          if(nL == null) nL = new NodePromoObj(yearLeft);
          if(nR == null) nR = new NodePromoObj(yearRight);
          e= new EdgePromoObj(nLid,nRid,count);        
          break;
        case "Demotion":
          if(nL == null) nL = new NodeDemoObj(yearLeft);
          if(nR == null) nR = new NodeDemoObj(yearRight);
          e= new EdgeDemoObj(nLid,nRid,count);
          break;
        case "NoChange":
          if(nL == null) nL = new NodeSameObj(yearLeft);
          if(nR == null) nR = new NodeSameObj(yearRight);
          e= new EdgeSameObj(nLid,nRid,count);
          break;
        case "Separated":
          if(nL == null) nL = new NodeSepObj(yearLeft);
          if(nR == null) nR = new NodeSepObj(yearRight);
          e= new EdgeSepObj(nLid,nRid,count);
          break;
      }
      if(yearLeft==minYear){nL.add(count);}
      nR.add(count);
      nodes.put(nLid,nL);
      nodes.put(nRid,nR);
      edges.add(e);
      
    }
     //calculating y positon of nodes and edges
     float currCount;
     NodeObj n;
     for(float y=minYear;y<=maxYear;y=y+1){
       currCount=0;
       //first starting nodes
       for(Map.Entry me : nodes.entrySet()) {
           n=(NodeObj)me.getValue();
           if(n instanceof NodeStartObj && n.getYear()==y) {n.setStartCount(currCount);currCount =currCount+ n.getCount();
             countEdge((String)me.getKey());}
       }
       //then promotions
       for(Map.Entry me : nodes.entrySet()) {
           n=(NodeObj)me.getValue();
           if(n instanceof NodePromoObj && n.getYear()==y) {n.setStartCount(currCount);currCount =currCount+ n.getCount();
             countEdge((String)me.getKey());}
       }
       //then no changes
       for(Map.Entry me : nodes.entrySet()) {
           n=(NodeObj)me.getValue();
           if(n instanceof NodeSameObj && n.getYear()==y) {n.setStartCount(currCount);currCount =currCount+ n.getCount();
           countEdge((String)me.getKey());}
       }
       //then demotions
       for(Map.Entry me : nodes.entrySet()) {
           n=(NodeObj)me.getValue();
           if(n instanceof NodeDemoObj && n.getYear()==y) {n.setStartCount(currCount);currCount =currCount+ n.getCount();
           countEdge((String)me.getKey());}
       }
       //then separations
       for(Map.Entry me : nodes.entrySet()) {
           n=(NodeObj)me.getValue();
           if(n instanceof NodeSepObj && n.getYear()==y) {n.setStartCount(currCount);currCount =currCount+ n.getCount();
           countEdge((String)me.getKey());}
       }
     }
      //<>//
    
  }
  
  private void countEdge(String nKey){
     //count the elements in each side of edges  
      
     float currCountL = 0;
     float currCountR = 0;
     
       println(nKey + " <<<<<< ");
      for(EdgeObj e : edges){
         //first promoitons
        if(e instanceof EdgePromoObj){
           if(nKey.equals(e.getNLid())) {e.setStartCountL(currCountL);currCountL = currCountL + e.getCount();}
           if(nKey.equals(e.getNRid())) {e.setStartCountR(currCountR);currCountR = currCountR + e.getCount();}
         }
       } 
       //then no job changes
       for(EdgeObj e : edges){
         if(e instanceof EdgeSameObj){
           if(nKey.equals(e.getNLid())) {e.setStartCountL(currCountL);currCountL = currCountL + e.getCount();}
           if(nKey.equals(e.getNRid())) {e.setStartCountR(currCountR);currCountR = currCountR + e.getCount();}
         }
       }
       //then demotions       
       for(EdgeObj e : edges){
         if(e instanceof EdgeDemoObj){
           if(nKey.equals(e.getNLid())) {e.setStartCountL(currCountL);currCountL = currCountL + e.getCount();}
           if(nKey.equals(e.getNRid())) {e.setStartCountR(currCountR);currCountR = currCountR + e.getCount();}
         }
       }
       //then separations
       for(EdgeObj e : edges){
         if(e instanceof EdgeSepObj){
           if(nKey.equals(e.getNLid())) {e.setStartCountL(currCountL);currCountL = currCountL + e.getCount();}
           if(nKey.equals(e.getNRid())) {e.setStartCountR(currCountR);currCountR = currCountR + e.getCount();}
         }
       }
       
  }
   
   
  public void calc(float x,float y,float w,float h){
     //calculate nodes location
     NodeObj n;
     for(Map.Entry me : nodes.entrySet()) {
       n=(NodeObj)me.getValue();
       n.calcNode(minYear, maxYear,maxCount,new PVector(x,y), new PVector(x+w,y+h));
     }
     //calculate edges location
     for(EdgeObj e : edges){
       e.calcEdge(nodes);
     }
  }
  
  public void drawAll(){
     //draw nodes 
     NodeObj n;
     for(Map.Entry me : nodes.entrySet()) {
       n=(NodeObj)me.getValue();
       n.drawNode();
     }
   //draw edges
    for(EdgeObj e : edges){
       e.drawEdge();
     }
  }
  
}
