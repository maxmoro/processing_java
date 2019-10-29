void setBricks(){
 for (int i=0;i<numBricks;i+=1){
   brickStatus[i]=1;
   bricksOn+=1;
 }
}

void drawBrick(int brick){
   int colr= ceil(brick / numBricksW*(255/numBricksH));
   fill(colr,colr,colr);
   if(brickStatus[brick]==2) fill (255,0,0);
   
   rect((brick % numBricksW)*bricksW
       ,ceil(brick / numBricksW)*bricksH+secTop
       ,bricksW,bricksH);
}

void drawBricks(){
 float x=0;
 float y=0;
 stroke(128);
 strokeWeight(1); 
 for (int i=0;i<numBricks;i+=1){
  if(brickStatus[i]!=0) drawBrick(i);
  
 }
}
