
Data data;

 
void setup()
{
 data = new Data();
 data.read("sankey_data_tot.csv");
 fullScreen();
 print(width);
 data.calc(width*.10,height*.10,width*.8,height*.8);
 
}


void draw()
{
  background(255);
  data.drawAll();
  fill(0);
  printText("Promotion Flow",width*.05,height*.05,width,height*.05,"L");
  printText("This chart shows the promotion flow of a sample population troughout 10 years of career",width*.10,height*.90,width,height*.025,"L");
  
  fill(26,150,65);
  rect(width*.01,height*.8,width*.06,height*.025);
  fill(255);
  printText("Promotion",width*.01,height*.805,width*.06,height*.025,"C");
  
  fill(8,48,107);
  rect(width*.01,height*.835,width*.06,height*.025);
  fill(255);
  printText("No Changes",width*.01,height*.840,width*.06,height*.025,"C");
  
  fill(215,25,28);
  rect(width*.01,height*.87,width*.06,height*.025);
   fill(255);
  printText("Demotions",width*.01,height*.875,width*.06,height*.025,"C");
  
  fill(64,64,64);
  rect(width*.01,height*.905,width*.06,height*.025);
   fill(255);
  printText("Separations",width*.01,height*.91,width*.06,height*.025,"C");
 
}
 
