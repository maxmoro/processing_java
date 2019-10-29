import processing.core.*; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; public class reading_freedom_application_v2 extends PApplet {// Ira Greenberg
// Reading Freedom, ver .01

int chapterCount = 9;
int articleCount = 115;
int artChapRatio = articleCount/(chapterCount-1);

float helixRadius = 300.0f;
float partRadius = 35.0f;

Icosahedron[] articles = new Icosahedron[articleCount];
int[] partCount = {
  0, 2, 4, 1, 1, 1, 1, 1, 1, 3, 1, 2, 3, 1, 2, 1, 2, 2, 2, 2, 3, 3, 1, 1, 2, 3, 1, 7, 1,5, 1, 2, 2, 2, 1, 5, 4, 6, 1, 2, 2, 4, 1, 2, 2, 13, 3, 1, 3, 4, 1, 5, 2, 1, 2, 2, 3, 1, 1, 2, 8, 2, 1, 1, 13, 2, 3, 1, 2, 5, 2, 1, 1, 2, 3, 1, 1, 2, 2, 1, 3, 2, 1, 3, 1, 3, 3, 3, 18, 2, 3, 1, 2, 1, 2, 2, 2, 2, 3, 2, 1, 3, 4, 2, 1, 3, 1, 4, 2, 1, 1, 1, 1, 3, 1 };

Cube[][] parts = new Cube[articleCount][18];

Vector3D[] articleLoc = new Vector3D[articleCount];
Vector3D[][] partLoc = new Vector3D[articleCount][18];

int[] chapterColors = { 
 0xffEEEEEE,
 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000, 0xffFF0000,
 0xff00FFFF, 0xff00FFFF, 0xff00FFFF, 0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,0xff00FFFF,
 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 0xffFFFF00, 
 0xffFF6600, 0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,0xffFF6600,
 0xff55FF11,
 0xff0011FF, 
 0xffFF00FF, 0xffFF00FF,0xffFF00FF,0xffFF00FF,0xffFF00FF,0xffFF00FF,0xffFF00FF,
 0xff0000FF, 0xff0000FF,0xff0000FF,0xff0000FF,0xff0000FF,0xff0000FF,0xff0000FF,0xff0000FF};

int[] mainNodeColors = new int[articleCount];
int[] partNodeColors = new int[articleCount];

float nodeCounter=0;
float partCounter=0;
int colConter = 0;

// controls rotating
boolean isRotateSafe = false;
float rotX, rotY;
float posX1, posY1;
float posX2, posY2;
float damping = .95f;

// controls dragging
boolean isDragSafe = false;
float nodePosX1, nodePosY1;
float  nodePosX2, nodePosY2;
int nodeID;


 Tendril tendril;
 float buildRate = .1f;

public void setup(){
  size(800, 600, P3D);
  // instantiate main article cubes
  for (int i=0; i<articleCount; i++){
    articles[i] = new Icosahedron(12);

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
    for (int j=0; j<partCount[i]; j++){
      parts[i][j] = new Cube(8, 8, 8);
    } 

  }
  calculateMainNodesLoc();
  calculateSubNodesLoc();
   // start helix spinning
   posX1 = -.35f;
}


public void draw(){
  background(20, 20, 35);
  noStroke();
  fill(170);

  translate(width/2, height/2, -320);
  ambient(185, 180, 185);
  lightSpecular(115, 110, 135);
  directionalLight(204, 204, 204, -.25f, .25f, -1);
  specular(195, 130, 195);
  shininess(10.0f); 

  if (isRotateSafe){
    posY1 = round(mouseY-posY2);
    posX1 = round(mouseX-posX2);
  }
  if (nodeCounter>articleCount-1){
    posY1 *= damping;
    posX1 *= damping;
  }
  rotY += posX1;
  rotX += -posY1;
  rotateY(radians(rotY));
  rotateX(radians(rotX));
 
  // custom rotation
  //rotate_z(radians(rotY));

  // update mx2, my2 to current mouse position
  posY2 = mouseY;
  posX2 = mouseX;

  drawTethers();
  // nodeCounter = 0;
  drawNodes();
  //
  checkMouseEvents();
}

public void drawTethers(){
 
  // connecting parts
  fill(175, 175, 235);
  tendril.create(IGConsts.RENDER_SKIN_DYNAMIC, .1f);
  noFill();
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
    nodeCounter+=buildRate;
  }
}

public void drawNodes(){
  noStroke();
  for (int i=0; i<nodeCounter; i++){
    articles[i].setLoc(articleLoc[i].x, articleLoc[i].y, articleLoc[i].z);
    fill(mainNodeColors[i]);
    articles[i].create();
    for (int j=0; j<partCount[i]; j++){
      parts[i][j].setLoc(partLoc[i][j].x, partLoc[i][j].y, partLoc[i][j].z);
      fill(partNodeColors[i]);
      parts[i][j].create();
    }
  }
}


// Calculate Main node positions
public void calculateMainNodesLoc(){
  float ax=0, ay= -height/2+15, az=0, aAng=0, aRad=helixRadius;
  for (int i=0; i<articleCount; i++){
    az = cos(aAng)*aRad;
    ax = sin(aAng)*aRad;
    ay+= (height-100)/100;
   // articles[i].setLoc(ax, ay, az);
    articleLoc[i] = new Vector3D(ax, ay, az);
    aAng+=TWO_PI/25;
  }
   tendril = new Tendril(articleLoc, 16, 3);
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
      partLoc[i][j] = new Vector3D(px, py, pz);
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

public void checkMouseEvents(){

  // turns off rotation and highlights nodes on mouseover
  for (int i=0; i<nodeCounter; i++){

    if (isDragSafe){
      isRotateSafe = false;
     // articleLoc[nodeID].x += mouseX-nodePosX1;
     // articleLoc[nodeID].y += mouseY-nodePosY1;
     // setSpring(nodeID, mouseY-nodePosY1);
     // nodePosX1 = mouseX;
    //  nodePosY1 = mouseY;
     // calculateSubNodesLoc();
    //  tendril.update(articleLoc);
    }

    if (mouseX > screenX(articles[i].x, articles[i].y, articles[i].z)-articles[i].radius &&
      mouseX < screenX(articles[i].x, articles[i].y, articles[i].z)+articles[i].radius &&
      mouseY > screenY(articles[i].x, articles[i].y, articles[i].z)-articles[i].radius &&
      mouseY < screenY(articles[i].x, articles[i].y, articles[i].z)+articles[i].radius){
      isRotateSafe = false;

      // highlight node
      pushMatrix();
      translate(articles[i].x, articles[i].y, articles[i].z);
      //lights();
      fill(255, 190, 190);
      new Icosahedron(14).create();
      popMatrix();
    }
  }
}


public void mouseReleased(){
  isRotateSafe = false;
  isDragSafe = false;
}


public void mousePressed(){
  for (int i=0; i<nodeCounter; i++){
    if (mouseX > screenX(articles[i].x, articles[i].y, articles[i].z)-articles[i].radius &&
      mouseX < screenX(articles[i].x, articles[i].y, articles[i].z)+articles[i].radius &&
      mouseY > screenY(articles[i].x, articles[i].y, articles[i].z)-articles[i].radius &&
      mouseY < screenY(articles[i].x, articles[i].y, articles[i].z)+articles[i].radius){

      nodePosX1 = mouseX;
      nodePosY1 = mouseY;
      isDragSafe = true;
      nodeID = i;
    }
  }

  isRotateSafe = true;
  posX2 = mouseX;
  posY2 = mouseY;
}


// custom rotations

public void rotate_z(float theta){
 // println(theta);
   float tx=0, ty=0, tz=0;
   for (int i=0; i< articles.length; i++){
     // top point
      tx = cos(theta)*articleLoc[i].x-sin(theta)*articleLoc[i].y;
      ty = sin(theta)*articleLoc[i].x+cos(theta)*articleLoc[i].y;
      articleLoc[i].x = tx;
      articleLoc[i].y = ty;
       calculateSubNodesLoc();
   }
}

 // HERE
 public void setSpring(int id, float delta){
   for (int i=0; i<articles.length; i++){
     if (i!=id){
      // println( delta);
     // println(1.0-(dist(articleLoc[id].x, articleLoc[id].y, articleLoc[id].z, articleLoc[i].x, articleLoc[i].y, articleLoc[i].z)-height/2)/1000);
      // articleLoc[i].y +=  delta*(1.0-(dist(articleLoc[id].x, articleLoc[id].y, articleLoc[id].z, articleLoc[i].x, articleLoc[i].y, articleLoc[i].z)-height/2)/1000);
      
     }
   }
     
 }


// Custom Cube class
class Cube extends Shape3D{
  Vector3D[] vertices = new Vector3D[8];
  int sides = 6;

  // Constructors
  // default constructor
  Cube(){
  }
  // constructor 2
  Cube(Dimension3D dim){
   super(dim);
    init();
  }
  // constructor 3
  Cube(float w, float h, float d){
    super(new Dimension3D(w, h, d));
    init();
  }
   
  // cube composed of 6 quads from 8 points
  public void init(){
    //front
    vertices[0] = new Vector3D(-w/2,-h/2,d/2);
    vertices[1] = new Vector3D(w/2,-h/2,d/2);
    vertices[2] = new Vector3D(w/2,h/2,d/2);
    vertices[3] = new Vector3D(-w/2,h/2,d/2);
    //back
    vertices[4] = new Vector3D(-w/2,-h/2,-d/2);
    vertices[5] = new Vector3D(w/2,-h/2,-d/2);
    vertices[6] = new Vector3D(w/2,h/2,-d/2);
    vertices[7] = new Vector3D(-w/2,h/2,-d/2);
  }

  public void create(){
    // build all quads clockwise

      // front
    beginShape(QUADS);
    vertex(x+vertices[0].x, y+vertices[0].y, z+vertices[0].z);
    vertex(x+vertices[1].x, y+vertices[1].y, z+vertices[1].z);
    vertex(x+vertices[2].x, y+vertices[2].y, z+vertices[2].z);
    vertex(x+vertices[3].x, y+vertices[3].y, z+vertices[3].z);
    endShape();

    // left
    beginShape(QUADS);
    vertex(x+vertices[4].x, y+vertices[4].y, z+vertices[4].z);
    vertex(x+vertices[0].x, y+vertices[0].y, z+vertices[0].z);
    vertex(x+vertices[3].x, y+vertices[3].y, z+vertices[3].z);
    vertex(x+vertices[7].x, y+vertices[7].y, z+vertices[7].z);
    endShape();

    //back
    beginShape(QUADS);
    vertex(x+vertices[5].x, y+vertices[5].y, z+vertices[5].z);
    vertex(x+vertices[4].x, y+vertices[4].y, z+vertices[4].z);
    vertex(x+vertices[7].x, y+vertices[7].y, z+vertices[7].z);
    vertex(x+vertices[6].x, y+vertices[6].y, z+vertices[6].z);
    endShape();

    // right
    beginShape(QUADS);
    vertex(x+vertices[1].x, y+vertices[1].y, z+vertices[1].z);
    vertex(x+vertices[5].x, y+vertices[5].y, z+vertices[5].z);
    vertex(x+vertices[6].x, y+vertices[6].y, z+vertices[6].z);
    vertex(x+vertices[2].x, y+vertices[2].y, z+vertices[2].z);
    endShape();

    // top
    beginShape(QUADS);
    vertex(x+vertices[4].x, y+vertices[4].y, z+vertices[4].z);
    vertex(x+vertices[5].x, y+vertices[5].y, z+vertices[5].z);
    vertex(x+vertices[1].x, y+vertices[1].y, z+vertices[1].z);
    vertex(x+vertices[0].x, y+vertices[0].y, z+vertices[0].z);
    endShape();

    // bottom
    beginShape(QUADS);
    vertex(x+vertices[3].x, y+vertices[3].y, z+vertices[3].z);
    vertex(x+vertices[2].x, y+vertices[2].y, z+vertices[2].z);
    vertex(x+vertices[6].x, y+vertices[6].y, z+vertices[6].z);
    vertex(x+vertices[7].x, y+vertices[7].y, z+vertices[7].z);
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

interface IGConsts{
  static int X_AXIS = 0;
  static int Y_AXIS = 1;
  static int Z_AXIS = 2;

  static int RENDER_PATH = 3;
  static int RENDER_CAGE = 4;
  static int RENDER_SKIN = 5;
  static int RENDER_PATH_DYNAMIC = 6;
  static int RENDER_CAGE_DYNAMIC = 7;
  static int RENDER_SKIN_DYNAMIC = 8;
}

class Icosahedron extends Shape3D{

  // icosahedron
  Vector3D topPoint;
  Vector3D[] topPent = new Vector3D[5];
  Vector3D bottomPoint;
  Vector3D[] bottomPent = new Vector3D[5];
  float angle = 0, radius = 150;
  float triDist;
  float triHt;
  float a, b, c;

  // constructor
  Icosahedron(float radius){
    this.radius = radius;
    init();
  }

  Icosahedron(Vector3D v, float radius){
    super(v);
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
      topPent[i] = new Vector3D(cos(angle)*radius, sin(angle)*radius, triHt/2.0f);
      angle+=radians(72);
    }
    topPoint = new Vector3D(0, 0, triHt/2.0f+a);
    angle = 72.0f/2.0f;
    for (int i=0; i<topPent.length; i++){
      bottomPent[i] = new Vector3D(cos(angle)*radius, sin(angle)*radius, -triHt/2.0f);
      angle+=radians(72);
    }
    bottomPoint = new Vector3D(0, 0, -(triHt/2.0f+a));
  }

  // draws icosahedron 
  public void create(){
    for (int i=0; i<topPent.length; i++){
      // icosahedron top
      beginShape();
      if (i<topPent.length-1){
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPoint.x, y+topPoint.y, z+topPoint.z);
        vertex(x+topPent[i+1].x, y+topPent[i+1].y, z+topPent[i+1].z);
      } 
      else {
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPoint.x, y+topPoint.y, z+topPoint.z);
        vertex(x+topPent[0].x, y+topPent[0].y, z+topPent[0].z);
      }
      endShape(CLOSE);

      // icosahedron bottom
      beginShape();
      if (i<bottomPent.length-1){
        vertex(x+bottomPent[i].x, y+bottomPent[i].y, z+bottomPent[i].z);
        vertex(x+bottomPoint.x, y+bottomPoint.y, z+bottomPoint.z);
        vertex(x+bottomPent[i+1].x, y+bottomPent[i+1].y, z+bottomPent[i+1].z);
      } 
      else {
        vertex(x+bottomPent[i].x, y+bottomPent[i].y, z+bottomPent[i].z);
        vertex(x+bottomPoint.x, y+bottomPoint.y, z+bottomPoint.z);
        vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
      }
      endShape(CLOSE);
    }

    // icosahedron body
    for (int i=0; i<topPent.length; i++){
      if (i<topPent.length-2){
        beginShape();
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+bottomPent[i+1].x, y+bottomPent[i+1].y, z+bottomPent[i+1].z);
        vertex(x+bottomPent[i+2].x, y+bottomPent[i+2].y, z+bottomPent[i+2].z);
        endShape(CLOSE);

        beginShape();
        vertex(x+bottomPent[i+2].x, y+bottomPent[i+2].y, z+bottomPent[i+2].z);
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPent[i+1].x, y+topPent[i+1].y, z+topPent[i+1].z);
        endShape(CLOSE);
      } 
      else if (i==topPent.length-2){
        beginShape();
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+bottomPent[i+1].x, y+bottomPent[i+1].y, z+bottomPent[i+1].z);
        vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
        endShape(CLOSE);

        beginShape();
        vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPent[i+1].x, y+topPent[i+1].y, z+topPent[i+1].z);
        endShape(CLOSE);
      }
      else if (i==topPent.length-1){
        beginShape();
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+bottomPent[0].x, y+bottomPent[0].y, z+bottomPent[0].z);
        vertex(x+bottomPent[1].x, y+bottomPent[1].y, z+bottomPent[1].z);
        endShape(CLOSE);

        beginShape();
        vertex(x+bottomPent[1].x, y+bottomPent[1].y, z+bottomPent[1].z);
        vertex(x+topPent[i].x, y+topPent[i].y, z+topPent[i].z);
        vertex(x+topPent[0].x, y+topPent[0].y, z+topPent[0].z);
        endShape(CLOSE);
      }
    }
  }

  // overrided methods fom Shape3D
  public void rotZ(float theta){
    float tx=0, ty=0, tz=0;
    // top point
    tx = cos(theta)*topPoint.x+sin(theta)*topPoint.y;
    ty = sin(theta)*topPoint.x-cos(theta)*topPoint.y;
    topPoint.x = tx;
    topPoint.y = ty;

    // bottom point
    tx = cos(theta)*bottomPoint.x+sin(theta)*bottomPoint.y;
    ty = sin(theta)*bottomPoint.x-cos(theta)*bottomPoint.y;
    bottomPoint.x = tx;
    bottomPoint.y = ty;

    // top and bottom pentagons
    for (int i=0; i<topPent.length; i++){
      tx = cos(theta)*topPent[i].x+sin(theta)*topPent[i].y;
      ty = sin(theta)*topPent[i].x-cos(theta)*topPent[i].y;
      topPent[i].x = tx;
      topPent[i].y = ty;

      tx = cos(theta)*bottomPent[i].x+sin(theta)*bottomPent[i].y;
      ty = sin(theta)*bottomPent[i].x-cos(theta)*bottomPent[i].y;
      bottomPent[i].x = tx;
      bottomPent[i].y = ty;
    }
  }

  public void rotX(float theta){
  }

  public void rotY(float theta){
  }


}

class Node3D extends Cube{
  float x, y, z;
  Shape3D shape;

   Node3D(Shape3D shape, Dimension3D d){
    super(d);
  }
  
  Node3D(Dimension3D d, float x, float y, float z){
    super(d);
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

class Polygon3D{

  Vector3D origin = new Vector3D(0, 0, 0);
  int vectorCount = 8;
  float radius = 50;
  Vector3D[] vecs;
  int axisAlignment = IGConsts.X_AXIS;

  Polygon3D(){
    init();
  }

  Polygon3D(Vector3D origin, int vectorCount, float radius, int axisAlignment){
    this.origin = origin;
    this.vectorCount = vectorCount;
    this.radius = radius;
    this.axisAlignment = axisAlignment;
    vecs = new Vector3D[vectorCount];
    init();
  }

  // init geometry
  public void init(){
    float px=0, py=0, pz=0, angle=0;
    switch(axisAlignment){
    case IGConsts.X_AXIS:
      px = origin.x;
      pz = origin.z + cos(radians(angle))*radius;
      py = origin.y + sin(radians(angle))*radius;
      vecs[0] =  new Vector3D(px, py, pz);
      angle+=360/vectorCount;
      for (int i=1; i<vectorCount; i++){
        pz = origin.z + cos(radians(angle))*radius;
        py = origin.y + sin(radians(angle))*radius;
        vecs[i] =  new Vector3D(px, py, pz);
        angle+=360/vectorCount;
      }
      break;
    case IGConsts.Y_AXIS:
      py = origin.y;
      px = origin.x + cos(radians(angle))*radius+random(-3, 3);
      pz = origin.z + sin(radians(angle))*radius+random(-3, 3);
      vecs[0] =  new Vector3D(px, py, pz);
      angle+=360/vectorCount;
      for (int i=1; i<vectorCount; i++){
        px = origin.x + cos(radians(angle))*radius+random(-3, 3);
        pz = origin.z + sin(radians(angle))*radius+random(-3, 3);
        vecs[i] =  new Vector3D(px, py, pz);
        angle+=360/vectorCount;
      }
      break;
    case IGConsts.Z_AXIS:
      pz = origin.z;
      px = origin.x + cos(radians(angle))*radius;
      py = origin.y + sin(radians(angle))*radius;
      vecs[0] =  new Vector3D(px, py, pz);
      angle+=360/vectorCount;
      for (int i=1; i<vectorCount; i++){
        px = origin.x + cos(radians(angle))*radius;
        py = origin.y + sin(radians(angle))*radius;
        vecs[i] =  new Vector3D(px, py, pz);
        angle+=360/vectorCount;
      }
      break;
    }
  }

  // draw polys
  public void create(){
    beginShape();
    for (int i=0; i<vecs.length; i++){
      vertex(vecs[i].x, vecs[i].y, vecs[i].z);
    }
    endShape(CLOSE);
  }
}

abstract class Shape3D{
  float x, y, z;
  float w, h, d;

  Shape3D(){
  }

  Shape3D(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }

  Shape3D(Vector3D p){
    x = p.x;
    y = p.y;
    z = p.z;
  }


  Shape3D(Dimension3D dim){
    w = dim.w;
    h = dim.h;
    d = dim.d;
  }

  Shape3D(float x, float y, float z, float w, float h, float d){
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }

  Shape3D(float x, float y, float z, Dimension3D dim){
    this.x = x;
    this.y = y;
    this.z = z;
    w = dim.w;
    h = dim.h;
    d = dim.d;
  }

  Shape3D(Vector3D p, Dimension3D dim){
    x = p.x;
    y = p.y;
    z = p.z;
    w = dim.w;
    h = dim.h;
    d = dim.d;
  }

  public void setLoc(Vector3D p){
    x=p.x;
    y=p.y;
    z=p.z;
  }

  public void setLoc(float x, float y, float z){
    this.x=x;
    this.y=y;
    this.z=z;
  }


  // override if you need these
  public void rotX(float theta){
  }

  public void rotY(float theta){
  }

  public void rotZ(float theta){
  }


  // must be implemented in subclasses
  public abstract void init();
  public abstract void create();
}

public class Tendril{
  // Initial path
  private Vector3D[] path;
  // Vectors between path nodes
  public Vector3D[] regVecs;
  // Cage polygons
  Polygon3D[] polys;
  private float xzAng, yzAng, xyAng;
  private float tempX, tempY, tempZ;
  private Vector3D worldOrigin = new Vector3D(0.0f,0.0f,0.0f);
  // Number of points on cage polygons
  private int polyDetail;
  // Tendril thickness
  private float polyRadius;

  private float polyCounter = 0.0f;

  public Tendril(Vector3D[] path, int polyDetail, float polyRadius){
    this.path = path;
    this.polyDetail = polyDetail;
    this.polyRadius = polyRadius;
    init();
  }

  private void update(Vector3D[] path){
    this.path = path;
    init();
  }

  private void init(){
    float bulgeAng = 0;
    regVecs = new Vector3D[path.length-1];
    polys = new Polygon3D[path.length-1];
    // generate vectors between each point on path
    for (int i=1; i<path.length; i+=1) {
      regVecs[i-1] = new Vector3D(path[i].x-path[i-1].x, path[i].y-path[i-1].y, path[i].z-path[i-1].z);
    }

    // 1. Calculate angles of rotation of path vectors in
    // reference to y and z-axes. 
    // 2. Use these values to transform vectors to 
    // orthogonal orientation.
    for (int i=0; i<regVecs.length; i++) {
      // Rotate around y-axis
      xzAng = atan2(regVecs[i].x, regVecs[i].z); // need this angle later
      tempZ = (float)(Math.cos(-xzAng+PI/2) * regVecs[i].z - Math.sin(-xzAng+PI/2) * regVecs[i].x);
      tempX = (float)(Math.sin(-xzAng+PI/2) * regVecs[i].z + Math.cos(-xzAng+PI/2) * regVecs[i].x);
      regVecs[i].z = tempZ;
      regVecs[i].x = tempX;

      // Rotate around z-axis
      xyAng = atan2(regVecs[i].y, regVecs[i].x); // need this angle later
      tempX = (float)(Math.cos(-xyAng) * regVecs[i].x - Math.sin(-xyAng) * regVecs[i].y);
      tempY = (float)(Math.sin(-xyAng) * regVecs[i].x + Math.cos(-xyAng) * regVecs[i].y);
      regVecs[i].x = tempX;
      regVecs[i].y = tempY;

      // 1. Construct polygons at world origin with same othogonal 
      // orientation as transformed vectors above.
      // (orientation is parallel to x-axis)
      // 2. Translate polygons back to original positions.
      // if (i<100){


     // polys[i] = new Polygon3D(worldOrigin, polyDetail, polyRadius*1.5+sin(bulgeAng+=.15)*(polyRadius/2), IGConsts.X_AXIS);
      polys[i] = new Polygon3D(worldOrigin, polyDetail, polyRadius, IGConsts.X_AXIS);
      polys[i].init();


      // Reverse order of vector rotations for
      // polygons. This order should mirror 
      // order of original sequence of rotations
      // e.g. AB = BA).
      for (int j=0; j<polys[i].vecs.length; j++){
        // Reverse Z-axis rotation by inverting 
        // theta (xzAng to -xzAxg) and use this value
        // to rotate polygons.
        tempX = (float)(Math.cos(xyAng) * polys[i].vecs[j].x - Math.sin(xyAng) * polys[i].vecs[j].y);
        tempY = (float)(Math.sin(xyAng) * polys[i].vecs[j].x + Math.cos(xyAng) * polys[i].vecs[j].y);
        polys[i].vecs[j].x = tempX;
        polys[i].vecs[j].y = tempY;

        // Reverse Y-axis rotation by inverting 
        // theta (-xzAng+PI/2 to xzAng-PI/2) and use this value
        // to rotate polygons. 
        tempZ = (float)(Math.cos(xzAng-PI/2) * polys[i].vecs[j].z - Math.sin(xzAng-PI/2) * polys[i].vecs[j].x);
        tempX = (float)(Math.sin(xzAng-PI/2) * polys[i].vecs[j].z + Math.cos(xzAng-PI/2) * polys[i].vecs[j].x);
        polys[i].vecs[j].z = tempZ;
        polys[i].vecs[j].x = tempX;

        // translate polygons back to original positions
        polys[i].vecs[j].add(path[i]);
      }
    }
  }

  public void create(int renderDetail, float dynamicCounter){
    switch(renderDetail){
    case IGConsts.RENDER_PATH:
      drawPath();
      break;
    case IGConsts.RENDER_CAGE:
      drawCage();
      break;
    case IGConsts.RENDER_SKIN:
      drawSkin();
      break;
    case IGConsts.RENDER_PATH_DYNAMIC:
      animatePath(dynamicCounter);
      break;
    case IGConsts.RENDER_CAGE_DYNAMIC:
      animateCage(dynamicCounter);
      break;
    case IGConsts.RENDER_SKIN_DYNAMIC:
      animateSkin(dynamicCounter);
      break;
    default:
      drawSkin();
    }
  }

  private void drawPath(){
    noFill();
    beginShape();
    for (int i=1; i<polys.length; i+=1){
      vertex(path[i].x, path[i].y, path[i].z);
    }
    endShape();
  }

  private void drawCage(){
    for (int i=1; i<polys.length; i+=1){
      polys[i].create();
    }
  }

  private void drawSkin(){
    for (int i=1; i<polys.length; i+=1){
      for (int j=1; j<polys[i].vecs.length; j++){
        beginShape(QUADS);
        vertex(polys[i-1].vecs[j-1].x, polys[i-1].vecs[j-1].y, polys[i-1].vecs[j-1].z);
        vertex(polys[i].vecs[j-1].x, polys[i].vecs[j-1].y, polys[i].vecs[j-1].z);
        vertex(polys[i].vecs[j].x, polys[i].vecs[j].y, polys[i].vecs[j].z);
        vertex(polys[i-1].vecs[j].x, polys[i-1].vecs[j].y, polys[i-1].vecs[j].z);
        endShape();
        // close tube
        if (j==polys[i].vecs.length-1){
          beginShape(QUADS);
          vertex(polys[i-1].vecs[j].x, polys[i-1].vecs[j].y, polys[i-1].vecs[j].z);
          vertex(polys[i].vecs[j].x, polys[i].vecs[j].y, polys[i].vecs[j].z);
          vertex(polys[i].vecs[0].x, polys[i].vecs[0].y, polys[i].vecs[0].z);
          vertex(polys[i-1].vecs[0].x, polys[i-1].vecs[0].y, polys[i-1].vecs[0].z);
          endShape();
        }
      }
    }
  }

  private void animatePath(float dynamicCounter){
    noFill();
    beginShape();
    for (int i=0; i<polyCounter; i++) {
      vertex(path[i].x, path[i].y, path[i].z);
    }
    endShape();
    if (polyCounter<polys.length-.1f){
      polyCounter+=dynamicCounter;
    }
  }

  private void animateCage(float dynamicCounter){
    for (int i=0; i<polyCounter; i+=1){
      polys[i].create();
    }
    if (polyCounter<polys.length-.1f){
      polyCounter+=dynamicCounter;
    }
  }

  private void animateSkin(float dynamicCounter){
    for (int i=1; i<polyCounter; i+=1){
      for (int j=1; j<polys[i].vecs.length; j++){
        beginShape(QUADS);
        vertex(polys[i-1].vecs[j-1].x, polys[i-1].vecs[j-1].y, polys[i-1].vecs[j-1].z);
        vertex(polys[i].vecs[j-1].x, polys[i].vecs[j-1].y, polys[i].vecs[j-1].z);
        vertex(polys[i].vecs[j].x, polys[i].vecs[j].y, polys[i].vecs[j].z);
        vertex(polys[i-1].vecs[j].x, polys[i-1].vecs[j].y, polys[i-1].vecs[j].z);
        endShape();
        // close tube
        if (j==polys[i].vecs.length-1){
          beginShape(QUADS);
          vertex(polys[i-1].vecs[j].x, polys[i-1].vecs[j].y, polys[i-1].vecs[j].z);
          vertex(polys[i].vecs[j].x, polys[i].vecs[j].y, polys[i].vecs[j].z);
          vertex(polys[i].vecs[0].x, polys[i].vecs[0].y, polys[i].vecs[0].z);
          vertex(polys[i-1].vecs[0].x, polys[i-1].vecs[0].y, polys[i-1].vecs[0].z);
          endShape();
        }
      }
    }
    if (polyCounter<polys.length-.1f){
     polyCounter+=dynamicCounter;
    }
  }
}

class Vector3D{
  float x, y, z;
  float[]origVals;

  Vector3D(){
  }

  Vector3D(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;

    // capture original values
    origVals  = new float[]{ 
      x, y, z     };
  }

  //methods
  public void add(Vector3D v){
    x+=v.x;
    y+=v.y;
    z+=v.z;
  }

  public void subtract(Vector3D v){
    x-=v.x;
    y-=v.y;
    z-=v.z;
  }

  public void multiply(float s){
    x*=s;
    y*=s;
    z*=s;
  }

  public void divide(float s){
    x/=s;
    y/=s;
    z/=s;
  }

  public Vector3D getAverage(Vector3D v){
    Vector3D u = new Vector3D();
    u.x = (x+v.x)/2;
    u.y = (y+v.y)/2;
    u.z = (z+v.z)/2;
    return u;
  }

  public void setTo(Vector3D v){
    x = v.x;
    y = v.y;
    z = v.z;
  }

  public void reset(){
    x = origVals[0];
    y = origVals[1];
    z = origVals[2];
  }

  public float getDotProduct(Vector3D v){
    return x*v.x + y*v.y + z*v.z;
  }

  public Vector3D getCrossProduct(Vector3D v, Vector3D u){
    Vector3D v1 = new Vector3D(v.x-x, v.y-y, v.z-z);
    Vector3D v2 = new Vector3D(u.x-x, u.y-y, u.z-z);
    float xx = v1.y*v2.z-v1.z*v2.y;
    float yy = v1.z*v2.x-v1.x*v2.z;
    float zz = v1.x*v2.y-v1.y*v2.x;
    return new Vector3D(xx, yy, zz);
  }

  public Vector3D getNormal(Vector3D v, Vector3D u){
    Vector3D n = getCrossProduct(v, u);
    n.normalize();
    return(n);
  }

  public void normalize(){
    float m = getMagnitude();
    x/=m;
    y/=m;
    z/=m;
  }

  public float getMagnitude(){
    return sqrt(x*x+y*y+z*z);
  }
}

  static public void main(String args[]) {     PApplet.main(new String[] { "reading_freedom_application_v2" });  }}