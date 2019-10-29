void setup(){
  size(600,800);
  background(255,225,225);
  int ellipseCount=400;
  float radius=30;
  float weight=1;
  noFill();
  for(int i=0; i<ellipseCount;i=i+1){
    weight=random(1,5);
    strokeWeight(weight);
    float dim =random(radius*2);
    ellipse(random(width),random(height),dim,dim);
  }
}
