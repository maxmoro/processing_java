float tempToday;

void setup(){
  tempToday=32.5;
  println(tempToday); 
}

void draw(){
 // println(tempToday);
}

void mousePressed(){
  println(tempToday);
  drawTriangle();
}

void drawTriangle(){
  triangle(random(10),random(15),30,45,20,60);
}
