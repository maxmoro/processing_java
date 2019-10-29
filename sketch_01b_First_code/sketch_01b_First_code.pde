void setup(){
  size(400,400);
  background(200,100,0);
  for(int i=0;i<50;i++){
    fill(random(255),random(255),random(255));
    rect(random(300),random(300),100,100);
  }
}
