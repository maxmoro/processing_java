Data data;
Bar bar;
float rotX=0.5339334; //1.2565;
float rotY=0.1600477 ; //.0658;
float rotZ=-1.2536798; //-1.0966;
float rotXs, rotYs,rotZs;
float ratio=0;
float ratioSp=0.01;
int selYearId=0;
String prevYear = "";


void setup()
{
  //fullScreen(P3D);
  size(1850,1000,P3D);
  
  data = new Data(this);
  data.read();
  
  bar = new Bar(this,data);
  
  bar.setYear(data.getYears().get(selYearId));
}

void draw()
{
  background(0);
  lights();
  pushMatrix();
    translate(width/2,height/2,0);
    rotX=rotX+rotXs;
    rotY=rotY+rotYs;
    rotZ=rotZ+rotZs;
    rotateY(rotY);
    rotateX(rotX);
    rotateZ(rotZ);
    ratio=ratio+ratioSp;
    if(ratio>1) ratio=1;
    noStroke();
    bar.render(ratio,prevYear);
  popMatrix();
  HUD();
}

void keyPressed()
{
  if(keyCode == UP)  {rotXs=+PI/100;rotYs=0;rotZs=0;}
  if(keyCode == DOWN)  {rotXs=-PI/100;rotYs=0;rotZs=0;}
  if(keyCode == RIGHT)  {rotYs=+PI/100;rotXs=0;rotZs=0;}  
  if(keyCode == LEFT)  {rotYs=-PI/100;rotXs=0;rotZs=0;}
  if(key == 'a') {rotZs=+PI/100;rotYs=0;rotXs=0;}
  if(key == 'z') {rotZs=-PI/100;rotYs=0;rotXs=0;}
  if(key == ' ') {rotZs=0;rotXs=0;rotYs=0;}
  if(key == 'y') {
    int id=0;
    prevYear=data.getYears().get(selYearId);
    int yearsNum=data.getYearssNum();
    selYearId = selYearId +1;
    if(selYearId>data.getYearssNum()-1) selYearId=0;
    bar.setYear(data.getYears().get(selYearId)); 
    ratio=0;
    ratioSp=0.05;

  }
  //print(rotX);
  //print(rotY);
  //println(rotZ);
  //println(selYearId);
  }
  
void HUD(){
 textMode(MODEL);
 bar.printText("Attrition by Job, Country, and Year",width*.01f, height*.02f,width*.4f,height*.08f,"L");
 bar.printText("Year " + data.getYears().get(selYearId) ,width*.01f, height*.02f,width*.95f,height*.08f,"R");
 bar.printText("Press Y  to change Year",width*.01f, height*.09f,width*.5f,height*.03f,"L");
 bar.printText("Press Arrows Right/Left to rotate the X axis",width*.01f, height*.90f,width*.5f,height*.02f,"L");
 bar.printText("Press Arrows Up/Down to rotate the Y axis",width*.01f, height*.92f,width*.5f,height*.02f,"L");
 bar.printText("Press A/Z  to rotate the Z axis",width*.01f, height*.94f,width*.5f,height*.02f,"L");
 bar.printText("Press SPACE to stop rotation ",width*.01f, height*.96f,width*.5f,height*.02f,"L");
}


   
