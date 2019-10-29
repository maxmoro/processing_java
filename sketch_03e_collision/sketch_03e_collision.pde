float x=100;
float y=100;
float speedX=4.12365;
float speedY=2;
void setup(){
  size(800,600);
  
}

void draw(){
  background(255);
  rect(x,y,30,30);
  x=x+speedX;
  y=y+speedY;
  
  if(x >= width || x<=0){
    speedX = -speedX;
  }
  if(y >= height || y<=0){
    speedY = -speedY;
  }
}
