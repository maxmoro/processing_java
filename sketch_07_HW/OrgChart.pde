class OrgChart {
 
 private OrgData data;
 private DataSource dataSource;
 private int autoMode;
 private float layerH;
 private float maxValue;
 private float boxStep= 0.11;
 private float boxStepInc=0.01;
  
 public OrgChart(DataSource dataSource){
    this.dataSource=dataSource;  
 }
  
 public void setBoxStep(float boxStep){this.boxStep=boxStep;}
  
 public void setBoxStepInc(float boxStepInc){this.boxStepInc=boxStepInc;}
  
 public void incBoxStep(){
    if(autoMode==1){
      boxStep=boxStep + boxStepInc;
      if(boxStep>=.85 || boxStep<=.1) boxStepInc=-boxStepInc;
    }
  }
    
  public void changeAutoMode(){
    autoMode++;
    if(autoMode>=2) autoMode=0;;
  }
    
  public void drawChart(float x, float y, float chartWidth, float chartHeight){
    int l = dataSource.getTotLayers();
    layerH=(chartHeight*.85)/l; //<>//
    maxValue = dataSource.getMaxValue();
    drawChartLoop(dataSource.getHead(), x+chartWidth*.05, y+chartHeight*.10, chartWidth*.9);
    //TEXT
    fill(0);
    printText("Organization Chart and Expenses Levels",chartWidth*.8,chartHeight*.05,x+chartWidth*.1,y+chartHeight*.05);
    printText("Hit Space to change Boxes",chartWidth*.2,chartHeight*.2,x+0,y+chartHeight*.01);
    printText("Last Update " + dataSource.getUpdateDate(),chartWidth*.5,chartHeight*.02,x+chartWidth*.5,y+chartHeight*.98);
    //LEGEND
    drawBox(x+chartWidth*.05,y+chartHeight*.90,chartHeight*.05,chartWidth*.1,10,"Within Budget");
    drawBox(x+chartWidth*.05,y+chartHeight*.95,chartHeight*.05,chartWidth*.1,-10,"Outside Budget");
    //printText("Green = Within Budget   | Red = Outside Budget",chartWidth*.5,chartHeight*.03,0,chartHeight*.98);
  }
  
  private void drawChartLoop(String parentId,float x,float y,float parentW){
    int childs = dataSource.getNumChilds(parentId);
    HashMap<String, OrgData> myData;
    myData = dataSource.getData();
    if(childs!=0){ //<>//
      float childW = parentW/childs;
      for(Map.Entry me : myData.entrySet()){
        data=(OrgData)me.getValue();
        if(int(data.parentId)==int(parentId)){
          drawBox(x,y,layerH,childW,data.value,data.name); //<>//
          drawChartLoop(data.id,x ,y+layerH+1,childW-1);
          x=x+childW+1;
        }
      }
    }
  }
    
  void drawBox(float x, float y, float h, float w, float value,String text){
    int r= 0;
    int b= 0;
    int g=0;
    int col = int(map(abs(value),0,abs(maxValue),50,200));
    if(value>0) g=col;
    if(value<=0) r=col;
    fill(r,g,b);
    stroke(0);
    strokeWeight(width/1000);
    
    if(autoMode==0) {rect(x,y,w,h);} 
     
    if(autoMode==1) {
      //Here the curve function, so I can meet the reqs
      beginShape();
        curveVertex(x,y);
        curveVertex(x,y);
        curveVertex(x+(boxStep*w),y);
        curveVertex(x+w,y);
        curveVertex(x+w,y+(boxStep*h));
        curveVertex(x+w,y+h);
        curveVertex(x+(boxStep*w),y+h);
        curveVertex(x,y+h);
        curveVertex(x,y+(boxStep*h));
        curveVertex(x,y);
        curveVertex(x,y);
      endShape();
    }
    
    pushMatrix();
      float wt=0;
      float ht=0;
      if(w>(h*.8)) {
        translate(x,y+h/2);
        wt=w;
        ht=h;
      } else {
        wt=h;
        ht=w;
        translate(x+w/2,y);
        rotate(PI/2.0);
      }
      fill(255);
      printText(text,wt,ht,0,0);
    popMatrix();
  }
  
  void printText(String text, float wt,float ht,float x, float y){
    textSize(12);
    float ts=0;
    float tsw=wt*.95/textWidth(text)*12;
    float tsh=ht*.98/textAscent()*12;
    if(tsh>tsw) ts=tsw; else ts=tsh;
    if(ts>80) ts=80;
    textSize(ts);
    text(text,x+(wt-textWidth(text))/2,y+textAscent()/2);
  }
}
