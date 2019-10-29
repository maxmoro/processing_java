void setBalls(){
 float ballsSpeedRatio =0.5; 
 for (int i=0;i<numBalls;i+=1){
   ballsX[i]=random(10,width*.9);
   ballsY[i]= random(secBottomStart+10,height);
   ballsSX[i]=random(-bricksW*ballsSpeedRatio,bricksW*ballsSpeedRatio);
   ballsSY[i]=random(-bricksH*ballsSpeedRatio,bricksH*ballsSpeedRatio);
   ballsCol[i] = color(random(255),random(255),random(255));
   println(ballsX[i]);
   println(ballsY[i]);
 }
}

void moveBalls(){
  float x;
  float y;
 for (int i=0;i<numBalls;i+=1){
   ballsX[i] += ballsSX[i];
   ballsY[i] += ballsSY[i];
   //collision screen
   if(ballsX[i]>width) {ballsX[i] = width; ballsSX[i] = -ballsSX[i];}
   if(ballsX[i]<0) {ballsX[i] = 0; ballsSX[i] = -ballsSX[i];}
   if(ballsY[i]>height) {ballsY[i] = height; ballsSY[i] = -ballsSY[i];}
   if(ballsY[i]<0) {ballsY[i] = 0; ballsSY[i] = -ballsSY[i];}
   //collision bricks
   for (int b=0;b<numBricks;b+=1){
     x=(b % numBricksW)*bricksW;
     y=ceil(b / numBricksW)*bricksH +secTop;
     if(ballsX[i] > x & ballsX[i] < (x+bricksW) 
       & ballsY[i] > y & ballsY[i] < (y+bricksH) 
       & brickStatus[b]!=0) {
          bricksOn =bricksOn-1;
          brickStatus[b]=brickStatus[b]-1;
          if((ballsX[i] - ballsSX[i]) <= x | (ballsX[i] - ballsSX[i]) >= (x+bricksW)) ballsSX[i] = -ballsSX[i];
          if((ballsY[i] - ballsSY[i]) <= y | (ballsY[i] - ballsSY[i]) >= (y+bricksH)) ballsSY[i] = -ballsSY[i];
          
     }
   }
  }
}

void drawBalls(){
 float x=0;
 float y=0;
  
 stroke(255,0,0);
 strokeWeight(1); 
 noStroke();
 
 float radius = bricksH/3;
 for (int i=0;i<numBalls;i+=1){
   fill(ballsCol[i]);
   ellipse(ballsX[i], ballsY[i],radius,radius);
   }
}
