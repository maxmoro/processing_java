int useInternet = 1; //set this to 0 to use local file, 1 to use internet data
Table table;
int[] id;
String[] name ;
int[] parent_id;
float[] value ;
String updatedate = new String();
int rows= 0;
int totRows = 0;
int autoMode = 1;
float boxStep=0.11;
float boxStepInc = .01;
int layers = 1;
float layerH = 0;
float maxValue = 0;

void setup(){
 
 if (useInternet==1) 
   table = loadTable("https://raw.githubusercontent.com/maxmoro/processing/master/org.csv","header");
 else 
   table = loadTable("org.csv","header");
 totRows = table.getRowCount();
 id = new int[totRows];
 name = new String[totRows];
 parent_id =  new int[totRows];
 value = new float[totRows];
 
 
 println(totRows + " total rows in table");
 

  for (TableRow trow : table.rows()) {
    id[rows] = trow.getInt("id");
    name[rows] = trow.getString("name") ;
    parent_id[rows] = trow.getInt("parent_id");
    value[rows] = trow.getFloat("value");
    if(rows==0) updatedate = trow.getString("update");
    if(value[rows] > maxValue) maxValue = value[rows];
    rows++;
  }
  fullScreen();
  //size(2048,1200);
  
  layers=getNumLayers(id[0]);
  layerH=(height*.85)/layers;
  
}

void draw(){
  if(autoMode==1)boxStep = boxStep + boxStepInc;
  if(boxStep>=.85 || boxStep<=.1) boxStepInc=-boxStepInc;
  
  
  background(255);
  fill(0);
  printText("Organization Chart and Expenses Levels",width*.8,height*.1,width*.1,height*.05);
  printText("Hit Space to change Boxes",width*.2,height*.2,0,height*.01);
  printText("Green = Within Budget   | Red = Outside Budget",width*.5,height*.03,0,height*.98);
  printText("Last Update " + updatedate,width*.5,height*.02,width*.5,height*.98);
  OrgChart(id[0], width*.05 ,height *.1, width*.9 );
  
}

void keyPressed(){
  if (key==' ') autoMode++;
  if(autoMode>=2) autoMode=0;
   
  
  
}
