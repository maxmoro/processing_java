// Inspired by https://youtu.be/ds0cmAV-Yek?t=364
// and http://bilimneguzellan.net/en/follow-up-to-fourier-series-2/
// by Max Moro

int sizeW =0;
int sizeH = 0;
int screenLeftW = 0;
int screenLeftH = 0;
int screenBottomW = 0;
int screenBottomH = 0;


int[] numHands = new int[2];
float[][] hRadius = new float[10][2];
float[][] hSpeed = new float[10][2];
float[][] hAngle = new float[10][2];
color[][] hColor = new color[10][2];

float[][] finalX = new float[15000][2];
float[][] finalY = new float[15000][2];
int countStep = 0 ;
int drawTailOn = 400;
int drawTail = drawTailOn;



void setup()
{
  fullScreen();
  //size(800,600);
  sizeW=width;
  sizeH=height;
  screenLeftW = sizeW*1/4;
  screenLeftH =  sizeH*8/12;
  screenBottomW = sizeW-screenLeftW;
  screenBottomH = sizeH-screenLeftH;

  
  setHands();
 }

void draw()
{
  drawBackground();
  countStep +=1;
  if(countStep==15000) countStep=1;
  println(countStep);
  pushMatrix();
    translate(screenLeftW/2,screenLeftH/2);
    buildHands(0,0);
    circle(0,0,10);
  popMatrix();
  
  pushMatrix();
    translate(screenLeftW+screenBottomW/2,screenLeftH+screenBottomH/2);
    buildHands(0,1);
    circle(0,0,10);
  popMatrix();
  
  
  drawCrossing();
  
}

void keyPressed(){
  if (key=='r') setHands();
  if (key=='t') if(drawTail == drawTailOn) drawTail=0; else drawTail=drawTailOn;
}
