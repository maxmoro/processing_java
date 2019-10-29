float x,y;
float speedX=5.2,speedY=2.75;
float radius=30;
void setup(){
  size(800,700);
  x=radius;
  y=radius;
  
}

void draw(){
  
  background(255);
   
  polygon(radius,9,2,color(200,200,0));
  polygon(radius/2 ,3,2,color(200,200,0));
  //rect(x,y,10,10);
  
  //speedY=speedY+1;
  x=x+speedX;
  y=y+speedY;
  checkCollisions();
}

void checkCollisions(){
  
  if(x + radius > width || x<=radius){
    speedX = -speedX;
  }
  if(y + radius > height || y<=radius){
    speedY = -speedY;
  }
}
