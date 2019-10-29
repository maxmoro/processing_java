class Bar{
  private Data data;
  private String year;
 
  
  
  public Bar(Data data){
     this.data = data;
     PImage tex = loadImage("USA.png");
  }
   
  public void setYear(String year){
    this.year = year;
   
  }
  
  public void render(float ratio,String prevYear){
    Datum datum;
    
    datum = new Datum();
    float w = width / 4 / data.getCountriesNum();
    float maxH = width*2;
    float h=0;
    float hpx=0;
    String txt = "";
    float diff=0;
    Datum prevDatum = new Datum();
    pushMatrix();
      translate(-data.getCountriesNum()*w/2,-data.getJobsNum()*w/2,0);
      int cCount=0;
      fill(255);
      for(String c: data.getCountries()){
        cCount+=1;
        translate(w,0,0);
        pushMatrix();
          rotateZ(PI/2);
          textSize(w/5);
          textAlign(RIGHT);
          text(c,0,0,0);
        popMatrix();
        pushMatrix();
          translate(0,w*(data.getJobsNum()+1),0);
          rotateZ(PI/2);
          textSize(w/5);
          textAlign(LEFT);
          text(c,0,0,0);
        popMatrix();
        
        pushMatrix();
          for(String j: data.getJobs()){
            if(cCount==01){
               pushMatrix();
                //rotateY(PI/2);
                
                translate(-w,w,0);
                textSize(w/5);
                textAlign(RIGHT);
                text(j,0,0,0);
              popMatrix();
              pushMatrix();
                //rotateY(PI/2);
                translate(w*(data.getJobsNum()),w,0);
                textSize(w/5);
                textAlign(RIGHT);
                text(j,0,0,0);
              popMatrix();
              
            }
            
            datum = data.filt(year,c,j);
             
            float prevAtt=0;
            if(prevYear != "") {
              prevDatum = data.filt(prevYear,c,j);
              prevAtt= prevDatum.attrition;
            }
            
            h = datum.attrition;
            diff = h - (prevAtt);
            h= h - diff*(1-ratio);
            hpx = h * maxH/100;
            
            translate(0,w,0);
            pushMatrix();
              fill(datum.col);
              translate(0,0,hpx/2);
              box(w*.95,w*.95,hpx);
             popMatrix();
            pushMatrix();
              translate(0,0,hpx*1.01);
              //rotateX(PI/2);
              textAlign(CENTER);
              fill(200);
              txt=nfs(h,0,1);
              printText(txt+ "%", 0, 0, w/2,w/2,"L");
            popMatrix();
            textAlign(LEFT);
            fill(255);
          }
        popMatrix();
      }
    popMatrix();
  }
}
