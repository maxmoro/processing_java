void drawBackground(){
  background(200);
  stroke(30);
  strokeWeight(1);
  fill(255);
  rect(screenLeftW,0,screenBottomW,screenLeftH);
  
  textSize(25);
  fill(0,0,200);
  text("'Drawing Hands (I need a Fourier Transformation)'",5,30);
  
  textSize(22);
  fill(200,0,0);
  
  text("Press 'r' for new random set.",5,sizeH-30);
  
  textSize(20);
  if(drawTail==0) text("Press 't' to activate trailing",550,sizeH-25); 
  else  text("Press 't' to show full trail.",550,sizeH-25);
  
  textSize(20);
  fill(50);
  text("Inspired by 'SmarterEveryDay' Youtube Channel (see code for the link)",5,65);
  
}
