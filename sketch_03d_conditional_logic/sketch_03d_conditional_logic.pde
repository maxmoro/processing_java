void setup(){
  size(1000,800);
  background(255,255,0);
  int shapeCount=500;
  int currentCount=0;
  while(currentCount<shapeCount){
    float radius=random(2,12);
    if(currentCount %2 ==0){
      rect(random(width),random(height),radius,radius);
    } else {
      ellipse(random(width),random(height),radius,radius);
    }
    currentCount=currentCount+1;
    
  }
}
