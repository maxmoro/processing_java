void setup(){
  size(400,400);
  background(50,25,5);
  ellipse(50,50,100,100);
  rect(200,200,100,100);
  
  print(getArea(100,100));
  int a=getArea(100,100);
  
}
void rect(float x, float y, float w, float h){
  ellipse(x,y,w,h);
}

int getArea(int w, int h){
  return (w*h);
}
