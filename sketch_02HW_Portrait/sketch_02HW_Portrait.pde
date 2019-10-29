int W = 1000;
int H = 800;
int panX = 0;
int panY = 0;

float zoomW = float(W)/2000;
float zoomH = float(H)/1400;

void drawFile(String fileName){
   
    BufferedReader reader = createReader(fileName);
    String line = null;
    int rx=0;
    int ry=0;
    int rcnt=0;
    try {
       beginShape();
      while ((line = reader.readLine()) != null) {
        String[] pieces = split(line, ',');
        rx = int(int(pieces[0])*zoomW+panX);
        ry = int(int(pieces[1])*zoomH+panY);
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
  size(W, H); 

}

void setup()
{
  
}
void draw()
{
   background(68,139,203);
    stroke(0,0,0);
    strokeWeight(1); fill(191,121,95); drawFile("00-Face.txt");
    strokeWeight(1); fill(27,25,14); drawFile("001-hairs.txt");
    strokeWeight(0); fill(11,9,12); drawFile("002-glasses.txt");
    
    strokeWeight(0); fill(191,121,95); drawFile("003-lens1.txt");
    strokeWeight(0); fill(171,157,148); drawFile("004-eye1.txt");
    strokeWeight(0); fill(45,25,16); ellipse(854*zoomW+panX,455*zoomH+panY,27*zoomW,27*zoomH);
    strokeWeight(0); fill(0,0,0,60); drawFile("003-lens1.txt");
    strokeWeight(6); noFill();stroke(92,58,45); drawFile("005-eyebr1.txt");stroke(0,0,0);
    
    
    strokeWeight(0); fill(191,121,95); drawFile("003-lens2.txt");
    strokeWeight(0); fill(171,157,148); drawFile("004-eye2.txt");
    strokeWeight(0); fill(45,25,16); ellipse(1079*zoomW+panX,454*zoomH+panY,27*zoomW,27*zoomH);
    strokeWeight(0); fill(0,0,0,60); drawFile("003-lens2.txt");
    strokeWeight(6); noFill();stroke(92,58,45); drawFile("005-eyebr2.txt");stroke(0,0,0);
    
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
  
    strokeWeight(8); stroke(255,0,0); noFill();rect(0+panX,0+panY,2000*zoomW,1400*zoomH);
  
}
