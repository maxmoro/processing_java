void drawCrossing(){
  stroke(2);
  line(finalX[countStep][0],finalY[countStep][0],sizeW,finalY[countStep][0]);
  line(finalX[countStep][1],finalY[countStep][1],finalX[countStep][1],0);
  stroke(0);
  strokeWeight(3);
  noFill();
  
  int startStep = 1;
  if(countStep>drawTail && drawTail>0) startStep = countStep-drawTail;
  beginShape();
    for(int i=startStep;i<countStep;i+=1){
      
      if(i==1 | i==countStep ) vertex(finalX[i][1],finalY[i][0]);
      vertex(finalX[i][1],finalY[i][0]);
    }
  endShape();
}
