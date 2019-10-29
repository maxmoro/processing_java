// Ira Greenberg
// Reading Freedom, ver .01

int chapterCount = 9;
int articleCount = 115;
int artChapRatio = articleCount/(chapterCount-1);

float helixRadius = 200.0;
float partRadius = 35.0;

Icosahedron[] articles = new Icosahedron[articleCount];
int[] partCount = {0, 2, 4, 1, 1, 1, 1, 1, 1, 3, 1, 2, 3, 1, 2, 1, 2, 2, 2, 2, 3, 3, 1, 1, 2, 3, 1, 7, 1,
                   5, 1, 2, 2, 2, 1, 5, 4, 6, 1, 2, 2, 4, 1, 2, 2, 13, 3, 1, 3, 4, 1, 5, 2, 1, 2, 2, 3, 
                   1, 1, 2, 8, 2, 1, 1, 13, 2, 3, 1, 2, 5, 2, 1, 1, 2, 3, 1, 1, 2, 2, 1, 3, 2, 1, 3, 1, 
                   3, 3, 3, 18, 2, 3, 1, 2, 1, 2, 2, 2, 2, 3, 2, 1, 3, 4, 2, 1, 3, 1, 4, 2, 1, 1, 1, 1, 3, 1 };
               
Cube[][] parts = new Cube[articleCount][18];

Point3D[] articleLoc = new Point3D[articleCount];
Point3D[][] partLoc = new Point3D[articleCount][18];

//color[] cols = new color[articleCount];
color[] chapterColors = { #EEEEEE,
#FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000,
#00FFFF, #00FFFF, #00FFFF, #00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,#00FFFF,
#FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, 
#FF3300, #FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,#FF3300,
#55FF11,
#0011FF, 
#FF00FF, #FF00FF,#FF00FF,#FF00FF,#FF00FF,#FF00FF,#FF00FF,
#0000FF, #0000FF,#0000FF,#0000FF,#0000FF,#0000FF,#0000FF,#0000FF, };
  
color[] mainNodeColors = new color[articleCount];
color[] partNodeColors = new color[articleCount];


float nodeCounter=0;
float partCounter=0;
int colConter = 0;


void setup(){
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
    r*=.5;
    g*=.5;
    r*=.5;
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


void draw(){
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

void drawTethers(){
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
    nodeCounter+=.1;
  }
}

void drawNodes(){
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
void calculateMainNodesLoc(){
  float ax=0, ay= -height/2+50, az=0, aAng=0, aRad=helixRadius;
  for (int i=0; i<articleCount; i++){
    az = cos(aAng)*aRad;
    ax = sin(aAng)*aRad;
    ay+= (height-100)/100;
    articleLoc[i] = new Point3D(ax, ay, az);
    aAng+=TWO_PI/25;
  }
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

void mouseMoved(){
  // if (mouseX>width/2+c.width/2
}
