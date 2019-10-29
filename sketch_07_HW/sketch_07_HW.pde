int useInternet = 1; //set this to 0 to use local file, 1 to use internet data
DataSource dataSource;
OrgChart orgChart;

void setup(){
  dataSource = new DataSource(useInternet);
  orgChart = new OrgChart(dataSource);
  fullScreen();
  //size(2048,1200);
   
}

void draw(){
  orgChart.incBoxStep(); // Increase animation step 
  
  background(255);
  orgChart.drawChart(0,0, width, height);
}

void keyPressed(){
  if (key==' ') orgChart.changeAutoMode();
}
 
