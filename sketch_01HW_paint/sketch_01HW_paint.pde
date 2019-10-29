// Link to original painting
// https://pin.it/e566ka5cssxsd7
// https://zoomik-city.co.uk/shop/suprematist-art-poster-5-minimalist-geometric/
 
int zoom = 4; //change this number to make it bigger or smalle (4 = 4x, 2=2x)
int size = 260 * zoom; //260 is the original size of the paint
void settings() {
  size(size,size);
}
void setup() {
  background(0,110,59);
 }

// custom function to draw a horizontal line using center position and half-width
void lineCenter(int centerX,int centerY,int l){
  line(centerX-l,centerY,centerX+l,centerY);
}

void draw() {
  //hlines
  stroke(0,2,0);
  strokeWeight(3*zoom);
  lineCenter(size/2,80*zoom,(130-68)*zoom);
  lineCenter(size/2,90*zoom,(130-55)*zoom);
  lineCenter(size/2,110*zoom,(130-57)*zoom);
  lineCenter(size/2,130*zoom,(130-54)*zoom);
  
  //triangle
  noStroke();
  fill(169,141,94);
  triangle(63*zoom,size+5*zoom,size/2,53*zoom,197*zoom,size+5*zoom);
  fill(36,44,65);
  triangle(64*zoom,size+5*zoom,size/2,210*zoom,196*zoom,size+5*zoom);
  
  //hlines over the triangle
  stroke(0,2,0);
  strokeWeight(3*zoom);
  lineCenter(size/2,100*zoom,(130-25)*zoom);  
  lineCenter(size/2,120*zoom,(130-25)*zoom);  
  
  //big circle
  stroke(147,128,60);
  strokeWeight(2*zoom);
  noFill();
  circle(size/2,size/2,(size-20*zoom) );
  
  //circles 
  noStroke();
  fill(183,54,48);
  circle(30*zoom,197*zoom,20*zoom);
  circle(230*zoom,197*zoom,20*zoom);
  fill(117,33,23);
  circle(size/2,170*zoom,40*zoom);
  
  //diagonal stripes
  stroke(178,160,110);
  strokeWeight(1);
  line(53*zoom,260*zoom,119*zoom,47*zoom);  
  line(73*zoom,213*zoom,138*zoom,3*zoom);
      
  //spots
  noStroke();
  fill(0,0,0,20); //transparency at 50/255, color black
  for(int i=0; i<25000; i++){
    // using a gaussian distribution with center at the center of the picture to make more natural
    // the '/3' is to consider 4 stdev of the guassian (99.73% of data)
    // the '+1.5' is to center the distribution to the middle of the picture 
    ellipse((randomGaussian()+1.5)/3*size,(randomGaussian()+2)/4*size,random(2*zoom),random(2*zoom));
    //ellipse(random(size),random(size),random(2*zoom),random(2*zoom));
  }
  noLoop();
  
}

// size(260*zoomnif,260*zoomnif);
