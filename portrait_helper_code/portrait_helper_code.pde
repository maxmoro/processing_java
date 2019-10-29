PImage img;
PrintWriter output;
int num = 5000;
int[] x = new int[num];
int[] y = new int[num];
int cur = -1;
int doPaint = 1;
int doBack = 1;


void drawFile(String fileName ){
   
    BufferedReader reader = createReader(fileName);
    String line = null;
    int rx=0;
    int ry=0;
    int rcnt=0;
    try {
       beginShape();
      while ((line = reader.readLine()) != null) {
        String[] pieces = split(line, ',');
        rx=  int(pieces[0]);
        ry = int(pieces[1]);
        if(rcnt==0) curveVertex(rx,ry);
        rcnt=rcnt+1;
        curveVertex(rx,ry);
      }
      curveVertex(rx,ry);
      endShape();
      reader.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
}


void settings() {
  img = loadImage("MaxPortrait.JPG");
  img.resize(int(img.width), int(img.height));
  println(img.width,img.height);
  size(img.width, img.height); 
}

void setup() {
  //background(img);
}

// runs 60 x per second
void draw() {
  clear();
  if(doBack ==1) background(img); else background(68,139,203);
  if(doPaint==1){
    //////// final painting //////
    stroke(0,0,0);
    strokeWeight(1); fill(191,121,95); drawFile("00-Face.txt");
    strokeWeight(1); fill(27,25,14); drawFile("001-hairs.txt");
    strokeWeight(0); fill(11,9,12); drawFile("002-glasses.txt");
    
    strokeWeight(0); fill(191,121,95); drawFile("003-lens1.txt");
    strokeWeight(0); fill(171,157,148); drawFile("004-eye1.txt");
    strokeWeight(0); fill(45,25,16); circle(854,455,27);
    strokeWeight(0); fill(255,255,255,20); drawFile("003-lens1.txt");
    strokeWeight(6); noFill();stroke(92,58,45); drawFile("005-eyebr1.txt");stroke(0,0,0);
    
    
    strokeWeight(0); fill(191,121,95); drawFile("003-lens2.txt");
    strokeWeight(0); fill(171,157,148); drawFile("004-eye2.txt");
    strokeWeight(0); fill(45,25,16); circle(1079,454,27);
    strokeWeight(0); fill(255,255,255,20); drawFile("003-lens2.txt");
    strokeWeight(6); noFill();stroke(92,58,45); drawFile("005-eyebr2.txt");stroke(0,0,0);
    
    //strokeWeight(0); fill(191,121,95); drawFile("006-nose.txt");
    strokeWeight(2); noFill(); drawFile("006-nose1.txt");
    strokeWeight(2); noFill(); drawFile("006-nose2.txt");
    strokeWeight(2); noFill(); drawFile("006-nose3.txt");
    
    strokeWeight(2); noFill(); drawFile("007-lipb.txt");
    strokeWeight(2); noFill(); drawFile("008-ear1.txt");
    strokeWeight(2); noFill(); drawFile("008-ear2.txt");
    strokeWeight(2); noFill(); drawFile("008-chin.txt");
    
    
    strokeWeight(1); fill(46,44,45); drawFile("01-grayShirt.txt");
    strokeWeight(1); fill(54,20,21); drawFile("02-redSkirt.txt");
    strokeWeight(5); noFill(); drawFile("03-grayLine1.txt");
    strokeWeight(8); noFill(); drawFile("04-grayZip.txt");
    strokeWeight(8); noFill(); drawFile("05-grayZip.txt");
    strokeWeight(8); noFill(); drawFile("06-ShirtBorder.txt");
    strokeWeight(1); fill(238,229,230); drawFile("07-WhiteShirt.txt");
    strokeWeight(3); noFill(); drawFile("09-shoulder.txt");
    
    //strokeWeight(1); noFill(); drawFile("01.txt");
  }
  
//////// final painting //////

  if (cur >= 0) {
    fill(255,255,255,50);
    stroke(255,255,255);
    strokeWeight(1); 
    beginShape();
    curveVertex(x[0],y[0]);
    for (int i=0; i<=cur;i++){
      curveVertex(x[i],y[i]);
    }
    curveVertex(x[cur],y[cur]);
    endShape();
  }
}
//
void mousePressed() {
  cur=cur+1;
  println(cur + ": " + mouseX + ", " + mouseY);
  x[cur]=mouseX;
  y[cur]=mouseY;
}

void keyPressed() {
  if (key=='w') {
    println("Writing");
    output = createWriter("positions.txt");
     
    for (int i=0; i<=cur;i++){
       output.println(str(x[i]) + ',' + str(y[i]));
    }
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
  }
  
  if (key=='c') {
    println("Clear");
    cur=-1;
  }
  
  if (key=='u') {
    println("Undo");
    cur=cur-1;
  }
  
  if (key=='r') {
    println("Reading");
    drawFile("positions.txt");
  }
  
  
  if (key=='p') {
    println("toggle pain");
    if(doPaint==1) doPaint=0; else doPaint=1;
  }
   if (key=='b') {
    println("toggle background");
    if(doBack==1) doBack=0; else doBack=1;
  }
}
