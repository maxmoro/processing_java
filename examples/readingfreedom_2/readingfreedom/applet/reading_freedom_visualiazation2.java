import processing.core.*; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; public class reading_freedom_visualiazation2 extends PApplet {// Ira Greenberg
// Reading Freedom, ver .01

int chapterCount = 9;
int articleCount = 115;
int artChapRatio = articleCount/(chapterCount-1);

float helixRadius = 200.0f;
float partRadius = 35.0f;

Icosahedron[] articles = new Icosahedron[articleCount];
int[] partCount = {0, 2, 4, 1, 1, 1, 1, 1, 1, 3, 1, 2, 3, 1, 2, 1, 2, 2, 2, 2, 3, 3, 1, 1, 2, 3, 1, 7, 1,
                   5, 1, 2, 2, 2, 1, 5, 4, 6, 1, 2, 2, 4, 1, 2, 2, 13, 3, 1, 3, 4, 1, 5, 2, 1, 2, 2, 3, 
                   1, 1, 2, 8, 2, 1, 1, 13, 2, 3, 1, 2, 5, 2, 1, 1, 2, 3, 1, 1, 2, 2, 1, 3, 2, 1, 3, 1, 
                   3, 3, 3, 18, 2, 3, 1, 2, 1, 2, 2, 2, 2, 3, 2, 1, 3, 4, 2, 1, 3, 1, 4, 2, 1, 1, 1, 1, 3, 1 };
               
Cube[][] parts = new Cube[articleCount][18];

Point3D[] articleLoc = new Point3D[articleCount];
Point3D[][] partLoc = new Point3D[articleCount][18];

//color[] cols = new color[articleCount];
int[] chapterColors = { 0xffEEEEEE,
0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000,
0xff00FFFF, 0xff00FFFF, 0xff00FFFF, 0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,
0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 
0xffFF3300, 0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,0xffFF3300,
0xff55FF11,
0xff0011FF, 
0xffFF00FF, 0xffFF00FF,0xffFF00FF,0xffFF00FF,0xffFF00FF,0xffFF00FF,0xffFF00FF,
0xff0000FF, 0xff0000FF,0xff0000FF,0xff0000FF,0xff0000FF,0xff0000FF,0xff0000FF,0xff0000FF, };
  
int[] mainNodeColors = new int[articleCount];
int[] partNodeColors = new int[articleCount];


float nodeCounter=0;
float partCounter=0;
int colConter = 0;


public void setup(){
  size(800, 600, P3D);
 println(partCount.length);
  // instantiate main article cubes
  for (int i=0; i<articleCount; i++){
    articles[i] = new Icosahedron(6);

   // cols[i] = color(random(255), random(255), random(255));
    mainNodeColors[i] =  chapterColors[i];
    //chapterColors[floor(i/artChapRatio)];
    float r = red(mainNodeColors[i]);
    float g = green(mainNodeColors[i]);
    float b = blue(mainNodeColors[i]);
    r*=.5f;
    g*=.5f;
    r*=.5f;
    partNodeColors[i] =  color(r, g, b);
  }

  // instantiate part cubes
  for (int i=0; i<articleCount; i++){
   // partCount[i] = round(random(4));
    for (int j=0; j<partCount[i]; j++){
      parts[i][j] = new Cube(5, 5, 5);
    } 
  }
  calculateMainNodesLoc();
  calculateSubNodesLoc();
}


public void draw(){
  background(20, 20, 35);
  //lights();
  noStroke();
  fill(170);

  translate(width/2, height/2, -200);
  lightSpecular(255, 255, 255);
  directionalLight(204, 204, 104, 0, 0, -1);
  specular(130, 130, 155);
  rotateX(-frameCount*PI/660);
  rotateY(-frameCount*PI/560);

  // calculateSubNodes();
  drawTethers();
  // nodeCounter = 0;
  drawNodes();
}

public void drawTethers(){
  noFill();
  // connecting parts


  for (int i=0; i<nodeCounter; i++){
    stroke(225);
    if (i<nodeCounter-1){
      beginShape();
      vertex(articleLoc[i].x, articleLoc[i].y, articleLoc[i].z);
      vertex(articleLoc[i+1].x, articleLoc[i+1].y, articleLoc[i+1].z);
      endShape();
    }
  }


  // articles - parts
  stroke(175);
  for (int i=0; i<nodeCounter; i++){
    beginShape();
    for (int j=0; j<partCount[i]; j++){
      vertex(articleLoc[i].x, articleLoc[i].y, articleLoc[i].z);
      vertex(partLoc[i][j].x, partLoc[i][j].y, partLoc[i][j].z);
    }
    endShape();
  }
  if(nodeCounter<(articleCount-1)){
    nodeCounter+=.1f;
  }
}

public void drawNodes(){
  noStroke();
  for (int i=0; i<nodeCounter; i++){
    pushMatrix();
    translate(articleLoc[i].x, articleLoc[i].y, articleLoc[i].z);
    fill(mainNodeColors[i]);
    articles[i].create();
    popMatrix();
    for (int j=0; j<partCount[i]; j++){
      pushMatrix();
      translate(partLoc[i][j].x, partLoc[i][j].y, partLoc[i][j].z);
      fill(partNodeColors[i]);
      parts[i][j].create();
      popMatrix();
    }
  }
}


// Calculate Main node positions
public void calculateMainNodesLoc(){
  float ax=0, ay= -height/2+50, az=0, aAng=0, aRad=helixRadius;
  for (int i=0; i<articleCount; i++){
    az = cos(aAng)*aRad;
    ax = sin(aAng)*aRad;
    ay+= (height-100)/100;
    articleLoc[i] = new Point3D(ax, ay, az);
    aAng+=TWO_PI/25;
  }
}

public void calculateSubNodesLoc(){
  float xzAng, yzAng, xyAng;
  float tempX, tempY, tempZ;
  float pTempX, pTempY, pTempZ;
  // move Nodes to origin
  // Rotate around y-axis
  for (int i=0; i<articleCount; i++){
    xzAng = atan2(articleLoc[i].x, articleLoc[i].z); // need this angle later
    tempZ = (float)(Math.cos(-xzAng+PI/2) * articleLoc[i].z - Math.sin(-xzAng+PI/2) * articleLoc[i].x);
    tempX = (float)(Math.sin(-xzAng+PI/2) * articleLoc[i].z + Math.cos(-xzAng+PI/2) * articleLoc[i].x);
    articleLoc[i].z = tempZ;
    articleLoc[i].x = tempX;

    // Rotate around z-axis
    xyAng = atan2(articleLoc[i].y, articleLoc[i].x); // need this angle later
    tempX = (float)(Math.cos(-xyAng) * articleLoc[i].x - Math.sin(-xyAng) * articleLoc[i].y);
    tempY = (float)(Math.sin(-xyAng) * articleLoc[i].x + Math.cos(-xyAng) * articleLoc[i].y);
    articleLoc[i].x = tempX;
    articleLoc[i].y = tempY;

    // draw subnodes around orthogonal main nodes
    float px=0, py=0, pz=0, pAng=0, pRad=partRadius;
    for (int j=0; j<partCount[i]; j++){
      px = articleLoc[i].x + cos(pAng) * pRad;
      py = articleLoc[i].y + sin(pAng) * pRad;
      pz = articleLoc[i].z;
      partLoc[i][j] = new Point3D(px, py, pz);
      pAng+=TWO_PI/partCount[i];
    }

    // Reverse Z-axis rotation by inverting 
    // theta (xzAng to -xzAxg) 
    tempX = (float)(Math.cos(xyAng) * articleLoc[i].x - Math.sin(xyAng) * articleLoc[i].y);
    tempY = (float)(Math.sin(xyAng) * articleLoc[i].x + Math.cos(xyAng) * articleLoc[i].y);
    articleLoc[i].x = tempX;
    articleLoc[i].y = tempY;

    // Reverse Y-axis rotation by inverting 
    // theta (-xzAng+PI/2 to xzAng-PI/2) and use this value
    // to rotate polygons. 
    tempZ = (float)(Math.cos(xzAng-PI/2) * articleLoc[i].z - Math.sin(xzAng-PI/2) * articleLoc[i].x);
    tempX = (float)(Math.sin(xzAng-PI/2) * articleLoc[i].z + Math.cos(xzAng-PI/2) * articleLoc[i].x);
    articleLoc[i].z = tempZ;
    articleLoc[i].x = tempX;

    // reverse subnodes
    for (int j=0; j<partCount[i]; j++){
      // Reverse Z-axis of subnodes
      pTempX = (float)(Math.cos(xyAng) *  partLoc[i][j].x - Math.sin(xyAng) *  partLoc[i][j].y);
      pTempY = (float)(Math.sin(xyAng) *  partLoc[i][j].x + Math.cos(xyAng) *  partLoc[i][j].y);
      partLoc[i][j].x = pTempX;
      partLoc[i][j].y = pTempY;

      // Reverse Y-axis of subnodes
      pTempZ = (float)(Math.cos(xzAng-PI/2) *  partLoc[i][j].z - Math.sin(xzAng-PI/2) *  partLoc[i][j].x);
      pTempX = (float)(Math.sin(xzAng-PI/2) *  partLoc[i][j].z + Math.cos(xzAng-PI/2) *  partLoc[i][j].x);
      partLoc[i][j].z = pTempZ;
      partLoc[i][j].x = pTempX;
    }
  }
}

public void mouseMoved(){
  // if (mouseX>width/2+c.width/2
}

// Custom Cube class
class Cube{
  Point3D[] vertices = new Point3D[8];
  int sides = 6;
  float w, h, d;

  // Constructors
  // default constructor
  Cube(){
  }
  // constructor 2
  Cube(Dimension3D dim){
    w = dim.w;
    h = dim.h;
    d = dim.d;
    init();
  }
  // constructor 3
  Cube(float w, float h, float d){
    this.w = w;
    this.h = h;
    this.d = d;
    init();
  }
  // cube composed of 6 quads from 8 points
  public void init(){
    //front
    vertices[0] = new Point3D(-w/2,-h/2,d/2);
    vertices[1] = new Point3D(w/2,-h/2,d/2);
    vertices[2] = new Point3D(w/2,h/2,d/2);
    vertices[3] = new Point3D(-w/2,h/2,d/2);
    //back
    vertices[4] = new Point3D(-w/2,-h/2,-d/2);
    vertices[5] = new Point3D(w/2,-h/2,-d/2);
    vertices[6] = new Point3D(w/2,h/2,-d/2);
    vertices[7] = new Point3D(-w/2,h/2,-d/2);
  }

  public void create(){
    // build all quads clockwise

      // front
    beginShape(QUADS);
    vertex(vertices[0].x, vertices[0].y, vertices[0].z);
    vertex(vertices[1].x, vertices[1].y, vertices[1].z);
    vertex(vertices[2].x, vertices[2].y, vertices[2].z);
    vertex(vertices[3].x, vertices[3].y, vertices[3].z);
    endShape();

    // left
    beginShape(QUADS);
    vertex(vertices[4].x, vertices[4].y, vertices[4].z);
    vertex(vertices[0].x, vertices[0].y, vertices[0].z);
    vertex(vertices[3].x, vertices[3].y, vertices[3].z);
    vertex(vertices[7].x, vertices[7].y, vertices[7].z);
    endShape();

    //back
    beginShape(QUADS);
    vertex(vertices[5].x, vertices[5].y, vertices[5].z);
    vertex(vertices[4].x, vertices[4].y, vertices[4].z);
    vertex(vertices[7].x, vertices[7].y, vertices[7].z);
    vertex(vertices[6].x, vertices[6].y, vertices[6].z);
    endShape();

    // right
    beginShape(QUADS);
    vertex(vertices[1].x, vertices[1].y, vertices[1].z);
    vertex(vertices[5].x, vertices[5].y, vertices[5].z);
    vertex(vertices[6].x, vertices[6].y, vertices[6].z);
    vertex(vertices[2].x, vertices[2].y, vertices[2].z);
    endShape();

    // top
    beginShape(QUADS);
    vertex(vertices[4].x, vertices[4].y, vertices[4].z);
    vertex(vertices[5].x, vertices[5].y, vertices[5].z);
    vertex(vertices[1].x, vertices[1].y, vertices[1].z);
    vertex(vertices[0].x, vertices[0].y, vertices[0].z);
    endShape();

    // bottom
    beginShape(QUADS);
    vertex(vertices[3].x, vertices[3].y, vertices[3].z);
    vertex(vertices[2].x, vertices[2].y, vertices[2].z);
    vertex(vertices[6].x, vertices[6].y, vertices[6].z);
    vertex(vertices[7].x, vertices[7].y, vertices[7].z);
    endShape();
  }
}

class Dimension3D{
   float w, h, d;
   
   Dimension3D(float w, float h, float d){
     this.w=w;
     this.h=h;
     this.d=d;
  }
}

class Icosahedron{

  // icosahedron
  Point3D topPoint;
  Point3D[] topPent = new Point3D[5];
  Point3D bottemPoint;
  Point3D[] bottemPent = new Point3D[5];
  float angle = 0, radius = 150;
  float triDist;
  float triHt;
  float a, b, c;

  // constructor
  Icosahedron(float radius){
    this.radius = radius;
    init();
  }

  // calculate geometry
  public void init(){
    c = dist(cos(0)*radius, sin(0)*radius, cos(radians(72))*radius,  sin(radians(72))*radius);
    b = radius;
    a = (float)(Math.sqrt(((c*c)-(b*b))));

    triHt = (float)(Math.sqrt((c*c)-((c/2)*(c/2))));

    for (int i=0; i<topPent.length; i++){
      topPent[i] = new Point3D(cos(angle)*radius, sin(angle)*radius, triHt/2.0f);
      angle+=radians(72);
    }
    topPoint = new Point3D(0, 0, triHt/2.0f+a);
    angle = 72.0f/2.0f;
    for (int i=0; i<topPent.length; i++){
      bottemPent[i] = new Point3D(cos(angle)*radius, sin(angle)*radius, -triHt/2.0f);
      angle+=radians(72);
    }
    bottemPoint = new Point3D(0, 0, -(triHt/2.0f+a));
  }

  // draws icosahedron 
  public void create(){
    for (int i=0; i<topPent.length; i++){
      // icosahedron top
      beginShape();
      if (i<topPent.length-1){
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPoint.x, topPoint.y, topPoint.z);
        vertex(topPent[i+1].x, topPent[i+1].y, topPent[i+1].z);
      } 
      else {
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPoint.x, topPoint.y, topPoint.z);
        vertex(topPent[0].x, topPent[0].y, topPent[0].z);
      }
      endShape(CLOSE);

      // icosahedron bottem
      beginShape();
      if (i<bottemPent.length-1){
        vertex(bottemPent[i].x, bottemPent[i].y, bottemPent[i].z);
        vertex(bottemPoint.x, bottemPoint.y, bottemPoint.z);
        vertex(bottemPent[i+1].x, bottemPent[i+1].y, bottemPent[i+1].z);
      } 
      else {
        vertex(bottemPent[i].x, bottemPent[i].y, bottemPent[i].z);
        vertex(bottemPoint.x, bottemPoint.y, bottemPoint.z);
        vertex(bottemPent[0].x, bottemPent[0].y, bottemPent[0].z);
      }
      endShape(CLOSE);
    }

    // icosahedron body
    for (int i=0; i<topPent.length; i++){
      if (i<topPent.length-2){
        beginShape();
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(bottemPent[i+1].x, bottemPent[i+1].y, bottemPent[i+1].z);
        vertex(bottemPent[i+2].x, bottemPent[i+2].y, bottemPent[i+2].z);
        endShape(CLOSE);

        beginShape();
        vertex(bottemPent[i+2].x, bottemPent[i+2].y, bottemPent[i+2].z);
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPent[i+1].x, topPent[i+1].y, topPent[i+1].z);
        endShape(CLOSE);
      } 
      else if (i==topPent.length-2){
        beginShape();
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(bottemPent[i+1].x, bottemPent[i+1].y, bottemPent[i+1].z);
        vertex(bottemPent[0].x, bottemPent[0].y, bottemPent[0].z);
        endShape(CLOSE);

        beginShape();
        vertex(bottemPent[0].x, bottemPent[0].y, bottemPent[0].z);
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPent[i+1].x, topPent[i+1].y, topPent[i+1].z);
        endShape(CLOSE);
      }
      else if (i==topPent.length-1){
        beginShape();
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(bottemPent[0].x, bottemPent[0].y, bottemPent[0].z);
        vertex(bottemPent[1].x, bottemPent[1].y, bottemPent[1].z);
        endShape(CLOSE);

        beginShape();
        vertex(bottemPent[1].x, bottemPent[1].y, bottemPent[1].z);
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPent[0].x, topPent[0].y, topPent[0].z);
        endShape(CLOSE);
      }
    }
  }
}

class Node3D extends Cube{
  float x, y, z;

   Node3D(Dimension3D d){
    super(d);
  }
  
  Node3D(Dimension3D d, float x, float y, float z){
    super(d);
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

public  class Point3D{
 public  float x, y, z;

 public   Point3D(){
  }

  public  Point3D(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

  static public void main(String args[]) {     PApplet.main(new String[] { "reading_freedom_visualiazation2" });  }}