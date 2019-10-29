import processing.core.*;
import java.util.ArrayList;
import processing.data.*;


class Bar{
  private Data data;
  private String year;
  protected PApplet p;
   
  public Bar(PApplet _p, Data data){
    p = _p;
     this.data = data;
     PImage tex = p.loadImage("USA.png");
  }
   
  public void setYear(String year){
    this.year = year;
   
  }
  
  public void render(float ratio,String prevYear){
    Datum datum;
    
    datum = new Datum();
    float w = p.width / 4 / data.getCountriesNum();
    float maxH = p.width*2;
    float h=0;
    float hpx=0;
    String txt = "";
    float diff=0;
    Datum prevDatum = new Datum();
    p.pushMatrix();
      p.translate(-data.getCountriesNum()*w/2,-data.getJobsNum()*w/2,0);
      int cCount=0;
      p.fill(255);
      for(String c: data.getCountries()){
        cCount+=1;
        p.translate(w,0,0);
        p.pushMatrix();
          p.rotateZ(p.PI/2);
          p.textSize(w/5);
          p.textAlign(p.RIGHT);
          p.text(c,0,0,0);
        p.popMatrix();
        p.pushMatrix();
          p.translate(0,w*(data.getJobsNum()+1),0);
          p.rotateZ(p.PI/2);
          p.textSize(w/5);
          p.textAlign(p.LEFT);
          p.text(c,0,0,0);
        p.popMatrix();
        
        p.pushMatrix();
          for(String j: data.getJobs()){
            if(cCount==01){
               p.pushMatrix();
                //rotateY(PI/2);
                
                p.translate(-w,w,0);
                p.textSize(w/5);
                p.textAlign(p.RIGHT);
                p.text(j,0,0,0);
              p.popMatrix();
              p.pushMatrix();
                //rotateY(PI/2);
                p.translate(w*(data.getJobsNum()),w,0);
                p.textSize(w/5);
                p.textAlign(p.RIGHT);
                p.text(j,0,0,0);
              p.popMatrix();
              
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
            
            p.translate(0,w,0);
            p.pushMatrix();
              p.fill(datum.col);
              p.translate(0,0,hpx/2);
              p.box(w*.95f,w*.95f,hpx);
             p.popMatrix();
            p.pushMatrix();
              p.translate(0f,0f,hpx*1.01f);
              //rotateX(PI/2);
              p.textAlign(p.CENTER);
              p.fill(200);
              txt=p.nfs(h,0,1);
              printText(txt+ "%", 0, 0, w/2,w/2,"L");
            p.popMatrix();
            p.textAlign(p.LEFT);
            p.fill(255);
          }
        p.popMatrix();
      }
    p.popMatrix();
  }
  
  public void printText(String text, float x, float y, float wt,float ht,String align){
    p.textSize(12);
    if(wt<0){x=x-(wt*2);wt=-wt;}
    
    if(ht<0){y=y-(ht*2);ht=-ht;}
    float ts=0;
    float tsw=wt*.95f/p.textWidth(text)*12f;
    float tsh=ht*.98f/p.textAscent()*12f;
    if(tsh>tsw) ts=tsw; else ts=tsh;
    if(ts>80) ts=80;
    p.textSize(ts);
    if(align=="" || align=="C") p.text(text,x+(wt-p.textWidth(text))/2,y+ht/2-p.textAscent()/99);
    if(align=="R") p.text(text,x+(wt-p.textWidth(text)),y+p.textAscent()/2);
    if(align=="L") p.text(text,x,y+p.textAscent()/2);
  }
}
