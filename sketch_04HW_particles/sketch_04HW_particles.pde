// by Max Moro

int sizeW =0;
int sizeH = 0;
int numBricksW=40;
int numBricksH=20;
int numBricks = numBricksW*numBricksH;
int[] brickStatus = new int[numBricks];
int bricksOn = 0;
float  bricksW =0;
float  bricksH =0;

int  numBalls = 50;
float[] ballsX = new float[numBalls];
float[] ballsY = new float[numBalls];
float[] ballsSX = new float[numBalls];
float[] ballsSY = new float[numBalls];
color[] ballsCol = new color[numBalls];

float secTop = 0;
float secBricks = 0;
float secBottomStart = 0;

void setup()
{
  fullScreen();
  //size(800,600);
  secTop = height*1/2*1/3;
  secBricks = height*1/2;
  secBottomStart = secTop+secBricks;
  bricksW = width / numBricksW;
  bricksH = secBricks / numBricksH;
  
  setBricks();
  setBalls();
  drawBackground();
  
}

void draw(){
  drawBackground();
  drawBricks();
  moveBalls();
  drawBalls();
 
 }
 
 void keyPressed(){
  if (key=='b' & bricksOn<numBricks) {
    int db=0;
    int b=int(random(1,numBricks-bricksOn));
    for(int i=0;i<numBricks;i+=1){
      if(brickStatus[i]==0) db=db+1;
      if(db==b) {brickStatus[i]=2; break;} //<>//
   }
  }
 }
