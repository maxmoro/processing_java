int mode = 0;
float Zmag = 21.1;
int Zaxis=-60;                                                       
float Xmag, Ymag = 0;
float newXmag, newYmag = 0; 
int newZmag = 0;
int zoomf = 3;
float newxpos, newypos = 0;       // for PAN
float xposd, yposd = 0;           // for PAN

//_________________________________________________________________ ROTATE / TILDE and MOVE / PAN
void mousePressed() {
  if      (mouseButton == LEFT)   { mode=1; }  // ORBIT
  else if (mouseButton == RIGHT)  { mode=2; }  // PAN
  // else if (mouseButton == CENTER) { mode=3; }  // zoom mouse wheel
}

//_________________________________________________________________ mouse PT end
void mouseReleased() { 
  mode = 0;
}

//_________________________________________________________________ mouseWheel ZOOM
void mouseWheel(MouseEvent event) {
  int newZmag = event.getCount();                                     // +- 1
  if (Zmag > 10) { Zmag += newZmag * 5; } else { Zmag += newZmag; }   // from 1 to 11 go in step 1 else in step 5 
}

void keyPressed(){
 if ( keyCode == UP   ) {Ymag -= 0.1 ;} 
 if ( keyCode == DOWN ) {Ymag += 0.1 ;} 
 if ( keyCode == RIGHT) {Xmag -= 0.1 ;} 
 if ( keyCode == LEFT ) {Xmag += 0.1 ;}
 
 if ( keyCode == 16 )   {Zmag -= 1 ;}
 if ( keyCode == 11 ) {Zmag += 1 ;}
 //println("key: "+key); println("keyCode: "+keyCode);
 
}
//_________________________________________________________________ Pan Tilde Zoom
void PTZ() {
  pushMatrix(); 
  translate(width/2, height/2, Zaxis);
  // get new mouse operation  
  if ( mode == 2 ) {                              // PAN ( right mouse button pressed)
    xposd = (mouseX-float(width/2));
    yposd = (mouseY-float(height/2));  
  }  
  newxpos = xposd;// xposd=0;
  newypos = yposd;// yposd = 0; 
  translate(newxpos,newypos, 0);          // move object
  if ( mode == 1 ) {  // ORBIT ( left mouse button pressed)
  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/float(height) * TWO_PI;
  
  float diff = Xmag-newXmag;
  if (abs(diff) >  0.01) {   Xmag -= diff/4.0; }
  diff = Ymag-newYmag;
  if (abs(diff) >  0.01) {   Ymag -= diff/4.0; }
  }
  rotateX(-Ymag);   rotateY(-Xmag);   
  scale(Zmag);
  
  draw_object();                                // THE OBJECT
  
  popMatrix();   
}

//_______________________________________________ SETUP PRINT INFO
void info_print() {
 println("PTZ info:");
 println("key UP DOWN RIGHT LEFT -> rotate // key PAGE UP DOWN -> zoom");
 println("mouse LEFT press drag up down right left -> rotate");
 println("mouse RIGHT press -> move ");
 println("mouse WHEEL turn -> zoom");
}
