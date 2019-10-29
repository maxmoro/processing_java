import processing.core.*; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; public class Exhibition_holding_page extends PApplet {// crazy flocking 3D birds

// flock array
int birdCount = 300;
Bird[]birds = new Bird[birdCount];
float[]x = new float[birdCount];
float[]y = new float[birdCount];
float[]z = new float[birdCount];
float[]rx = new float[birdCount];
float[]ry = new float[birdCount];
float[]rz = new float[birdCount];
float[]spd = new float[birdCount];
float[]rot = new float[birdCount];

PFont f;
public void setup(){
  size(600, 600, P3D);
  background(90);
 // smooth();
  f = loadFont("ArialMT-48.vlw");
  
   //iniitalize arrays with random values
  for (int i=0; i<birdCount; i++){
    birds[i] = new Bird(random(-300, 300), random(-300, 300), 
                random(-4500, -2500), random(5, 30), random(5, 30)); 
                        
    birds[i].setColor(color(random(255), random(255), random(255)), 
                   color(random(255), random(255), random(255)));
                   
    x[i] = random(20, 340);
    y[i] = random(-200, 650);
    z[i] = random(1000, 1800);
    rx[i] = random(-360, 660);
    ry[i] = random(-255, 455);
    rz[i] = random(-20, 20);
    spd[i] = random(.1f, 2.5f);
    rot[i] = random(.025f, .45f);
  }
}

public void draw(){
  background(90);
  fill(255, 255, 255);
  textFont(f, 35);
  textAlign(CENTER);
  text("Reading Freedom:\nVisualizing the Constitution\nof the Czech Republic.\n", width/2, 100);
  textFont(f, 20);
  text("Ira Greenberg, 2008", width/2, 215);
  textFont(f, 42);
  fill(200, 100, 10);
  text("Coming May 6th 2008", width/2, 320);


  fill(0, 0, 0);
  textFont(f, 16);
  textAlign(LEFT);
  text( 
    "   Institute of Art and Design\n"+
    "   University of West Bohemia\n"+
    "   Pilsen, Czech Republic", 40, 500);

  textFont(f, 16);
  textAlign(LEFT);
  text( 
    "   School of Fine Arts\n"+
    "   Miami University of Ohio\n"+
    "   Oxford, Ohio", 375, 500);
    
     lights();
  for (int i=0; i<birdCount; i++){
   noStroke();
   birds[i].setFlight(x[i], y[i], z[i], rx[i], ry[i], rz[i]);
    birds[i].setWingSpeed(spd[i]);
    birds[i].setRotSpeed(rot[i]);
    birds[i].fly();
  }



}


/*from:
 School of Fine Arts
 Miami University of Ohio
 Oxford, Ohio
 */
 
 class Bird{
  // properties
  float offsetX, offsetY, offsetZ;
  float w, h;
  int bodyFill;
  int wingFill;
  float ang = 0, ang2 = 0, ang3 = 0, ang4 = 0;
  float radiusX = 120, radiusY = 200, radiusZ = 700;
  float rotX = 15, rotY = 10, rotZ = 5;
  float flapSpeed = .4f;
  float rotSpeed = .1f;

  // constructors
  Bird(){
    this(0, 0, 0, 60, 80);
  }

  Bird(float offsetX, float offsetY, float offsetZ, 
       float w, float h){
    this.offsetX = offsetX;
    this.offsetY = offsetY;
    this.offsetZ = offsetZ;
    this.h=h;
    this.w=w;
    bodyFill = color(200, 100, 10);
    wingFill = color(200, 200, 20);
  }

  // methods
  public void setColor(int bodyFill, int wingFill){
    this.bodyFill=bodyFill;
    this.wingFill=wingFill;
  }

  public void setFlight(float radiusX, float radiusY, float radiusZ, 
                float rotX, float rotY, float rotZ){
    this.radiusX = radiusX;
    this.radiusY = radiusY;
    this.radiusZ = radiusZ;

    this.rotX = rotX;
    this.rotY = rotY;
    this.rotZ = rotZ;
  }

  public void setWingSpeed(float flapSpeed){
    this.flapSpeed = flapSpeed;
  }

  public void setRotSpeed(float rotSpeed){
    this.rotSpeed = rotSpeed;
  }

  public void fly(){
    pushMatrix();
    float px, py, pz;
    fill(bodyFill);
    //flight
    px = sin(radians(ang3))*radiusX;
    py = cos(radians(ang3))*radiusY;
    pz = sin(radians(ang4))*radiusZ;
    //
    translate(width/2+offsetX+px, height/2+offsetY+py, 
            -500+offsetZ+pz);

    rotateX(sin(radians(ang2))*rotX);
    rotateY(sin(radians(ang2))*rotY);
    rotateZ(sin(radians(ang2))*rotZ);
    //

    //body
    box(w/5, h, w/5);

    fill(wingFill);
    //left wing
    pushMatrix();
    rotateY(sin(radians(ang))*20);
    rect(0, -h/2, w, h);
    popMatrix();

    //right wing
    pushMatrix();
    rotateY(sin(radians(ang))*-20);
    rect(-w, -h/2, w, h);
    popMatrix();

    // wing flap
    ang+=flapSpeed;
    if (ang>3){
      flapSpeed*=-1;
    } 
    if (ang<-3){
      flapSpeed*=-1;
    }

    // ang's run trig functions
    ang2+=rotSpeed;
    ang3+=1.25f;
    ang4+=.55f;
    popMatrix();
  }
}


  static public void main(String args[]) {     PApplet.main(new String[] { "Exhibition_holding_page" });  }}