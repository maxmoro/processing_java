// Ira Greenberg
// Reading Freedom, ver .01

int chapterCount = 9;
int articleCount = 115;
int artChapRatio = articleCount/(chapterCount-1);

float helixRadius = 300.0;
float partRadius = 35.0;

Icosahedron[] articles = new Icosahedron[articleCount];
int[] partCount = {
  0, 2, 4, 1, 1, 1, 1, 1, 1, 3, 1, 2, 3, 1, 2, 1, 2, 2, 2, 2, 3, 3, 1, 1, 2, 3, 1, 7, 1,5, 1, 2, 2, 2, 1, 5, 4, 6, 1, 2, 2, 4, 1, 2, 2, 13, 3, 1, 3, 4, 1, 5, 2, 1, 2, 2, 3, 1, 1, 2, 8, 2, 1, 1, 13, 2, 3, 1, 2, 5, 2, 1, 1, 2, 3, 1, 1, 2, 2, 1, 3, 2, 1, 3, 1, 3, 3, 3, 18, 2, 3, 1, 2, 1, 2, 2, 2, 2, 3, 2, 1, 3, 4, 2, 1, 3, 1, 4, 2, 1, 1, 1, 1, 3, 1 };

Cube[][] parts = new Cube[articleCount][18];

Vector3D[] articleLoc = new Vector3D[articleCount];
Vector3D[][] partLoc = new Vector3D[articleCount][18];

color[] chapterColors = { 
 #EEEEEE,
 #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000,
 #00FFFF, #00FFFF, #00FFFF, #00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,
 #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, 
 #FF6600, #FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,#FF6600,
 #55FF11,
 #0011FF, 
 #FF00FF, #FF00FF,#FF00FF,#FF00FF,#FF00FF,#FF00FF,#FF00FF,
 #0000FF, #0000FF,#0000FF,#0000FF,#0000FF,#0000FF,#0000FF,#0000FF};

color[] mainNodeColors = new color[articleCount];
color[] partNodeColors = new color[articleCount];

float nodeCounter=0;
float partCounter=0;
int colConter = 0;

// controls rotating
boolean isRotateSafe = false;
float rotX, rotY;
float posX1, posY1;
float posX2, posY2;
float damping = .95;

// controls dragging
boolean isDragSafe = false;
float nodePosX1, nodePosY1;
float  nodePosX2, nodePosY2;
int nodeID;


 Tendril tendril;
 float buildRate = .1;

void setup(){
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
    r*=.5;
    g*=.5;
    r*=.5;
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
   posX1 = -.35;
}


void draw(){
  background(20, 20, 35);
  noStroke();
  fill(170);

  translate(width/2, height/2, -320);
  ambient(185, 180, 185);
  lightSpecular(115, 110, 135);
  directionalLight(204, 204, 204, -.25, .25, -1);
  specular(195, 130, 195);
  shininess(10.0); 

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

void drawTethers(){
 
  // connecting parts
  fill(175, 175, 235);
  tendril.create(IGConsts.RENDER_SKIN_DYNAMIC, .1);
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

void drawNodes(){
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
void calculateMainNodesLoc(){
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

void calculateSubNodesLoc(){
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

void checkMouseEvents(){

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


void mouseReleased(){
  isRotateSafe = false;
  isDragSafe = false;
}


void mousePressed(){
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

void rotate_z(float theta){
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
 void setSpring(int id, float delta){
   for (int i=0; i<articles.length; i++){
     if (i!=id){
      // println( delta);
     // println(1.0-(dist(articleLoc[id].x, articleLoc[id].y, articleLoc[id].z, articleLoc[i].x, articleLoc[i].y, articleLoc[i].z)-height/2)/1000);
      // articleLoc[i].y +=  delta*(1.0-(dist(articleLoc[id].x, articleLoc[id].y, articleLoc[id].z, articleLoc[i].x, articleLoc[i].y, articleLoc[i].z)-height/2)/1000);
      
     }
   }
     
 }

