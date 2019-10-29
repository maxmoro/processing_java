void OrgChart(int parent ,float x ,float y, float parentW ){
  int childs = getNumChilds(parent);
  if(childs!=0){
    float childW = parentW/childs;
    for(int row=0; row< rows; row++){
      if(parent_id[row]==parent){
        drawBox(x,y,layerH,childW,value[row],name[row]);
        OrgChart(id[row], x ,y+layerH+1,childW);
        x=x+childW+1;
      }
    }
  }

}

int getNumLayers(int parent){
  int childs = getNumChilds(parent);
  int layer=0;
  int childsMax=0;
  int childsCount=0;
  if(childs!=0){
    layer=1;
    for(int row=0; row< rows; row++){
      if(parent_id[row]==parent){
        childsCount=getNumLayers(id[row]);
        if(childsCount>childsMax) childsMax= childsCount;
      }
    }
    layer = layer +childsMax;
  }
  return(layer);

}

int getNumChilds(int parent){
  int num_childs=0;
  for(int row=0; row< rows; row++){
    if(parent_id[row]==parent) num_childs++;
  }
  return(num_childs);
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
  
  if(autoMode==0) {
    rect(x,y,w,h);
  } 
   
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
