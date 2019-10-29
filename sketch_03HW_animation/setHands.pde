void setHands(){
   //creating random sizes and speed
  numHands[0]=int(random(3,10));
  numHands[1]=int(random(3,10));
  countStep=0;
   for(int h=0;h<=1;h+=1){
     float cR = 70;
     float cS = 0.00;
     //float cRs = random(-10,10);
     //float cSs = random(-.007,.007);
     for(int i=0;i<numHands[h];i+=1){
       //hRadius[i][h] = random(10,200);
       //hSpeed[i][h] = random(0,0.05);
       float cSs = random(-.02,.02);
       float cRs = random(-40,40);
       cR= cR + cRs;
       cS= cS + cSs;
       hRadius[i][h] = cR  ;
       hSpeed[i][h] = cS ;
       hColor[i][h] = color(random(255),random(255),random(255));
     }
   }
   
 }
