public void buildHands(int hand,int set ){
  if(hand<numHands[set]){
    pushMatrix();
      hAngle[hand][set]+=hSpeed[hand][set];
      rotate(hAngle[hand][set]);
      fill(hColor[hand][set]);
      stroke(20);
      strokeWeight(1);
      
      drawHand(hRadius[hand][set]);
      translate(hRadius[hand][set],0);
      
      buildHands(hand+1,set);
      
    popMatrix();
  } else {
    finalX[countStep][set] = screenX(0, 0);
    finalY[countStep][set] = screenY(0, 0);
  }
  
}
