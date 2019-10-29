class Icosahedron{

  // icosahedron
  Point3D topPoint;
  Point3D[] topPent = new Point3D[5];
  Point3D bottemPoint;
  Point3D[] bottemPent = new Point3D[5];
  float angle = 0, radius = 150;
  float triDist;
  float triHt;
  float a, b, c;

  // constructor
  Icosahedron(float radius){
    this.radius = radius;
    init();
  }

  // calculate geometry
  void init(){
    c = dist(cos(0)*radius, sin(0)*radius, cos(radians(72))*radius,  sin(radians(72))*radius);
    b = radius;
    a = (float)(Math.sqrt(((c*c)-(b*b))));

    triHt = (float)(Math.sqrt((c*c)-((c/2)*(c/2))));

    for (int i=0; i<topPent.length; i++){
      topPent[i] = new Point3D(cos(angle)*radius, sin(angle)*radius, triHt/2.0f);
      angle+=radians(72);
    }
    topPoint = new Point3D(0, 0, triHt/2.0f+a);
    angle = 72.0f/2.0f;
    for (int i=0; i<topPent.length; i++){
      bottemPent[i] = new Point3D(cos(angle)*radius, sin(angle)*radius, -triHt/2.0f);
      angle+=radians(72);
    }
    bottemPoint = new Point3D(0, 0, -(triHt/2.0f+a));
  }

  // draws icosahedron 
  void create(){
    for (int i=0; i<topPent.length; i++){
      // icosahedron top
      beginShape();
      if (i<topPent.length-1){
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPoint.x, topPoint.y, topPoint.z);
        vertex(topPent[i+1].x, topPent[i+1].y, topPent[i+1].z);
      } 
      else {
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPoint.x, topPoint.y, topPoint.z);
        vertex(topPent[0].x, topPent[0].y, topPent[0].z);
      }
      endShape(CLOSE);

      // icosahedron bottem
      beginShape();
      if (i<bottemPent.length-1){
        vertex(bottemPent[i].x, bottemPent[i].y, bottemPent[i].z);
        vertex(bottemPoint.x, bottemPoint.y, bottemPoint.z);
        vertex(bottemPent[i+1].x, bottemPent[i+1].y, bottemPent[i+1].z);
      } 
      else {
        vertex(bottemPent[i].x, bottemPent[i].y, bottemPent[i].z);
        vertex(bottemPoint.x, bottemPoint.y, bottemPoint.z);
        vertex(bottemPent[0].x, bottemPent[0].y, bottemPent[0].z);
      }
      endShape(CLOSE);
    }

    // icosahedron body
    for (int i=0; i<topPent.length; i++){
      if (i<topPent.length-2){
        beginShape();
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(bottemPent[i+1].x, bottemPent[i+1].y, bottemPent[i+1].z);
        vertex(bottemPent[i+2].x, bottemPent[i+2].y, bottemPent[i+2].z);
        endShape(CLOSE);

        beginShape();
        vertex(bottemPent[i+2].x, bottemPent[i+2].y, bottemPent[i+2].z);
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPent[i+1].x, topPent[i+1].y, topPent[i+1].z);
        endShape(CLOSE);
      } 
      else if (i==topPent.length-2){
        beginShape();
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(bottemPent[i+1].x, bottemPent[i+1].y, bottemPent[i+1].z);
        vertex(bottemPent[0].x, bottemPent[0].y, bottemPent[0].z);
        endShape(CLOSE);

        beginShape();
        vertex(bottemPent[0].x, bottemPent[0].y, bottemPent[0].z);
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPent[i+1].x, topPent[i+1].y, topPent[i+1].z);
        endShape(CLOSE);
      }
      else if (i==topPent.length-1){
        beginShape();
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(bottemPent[0].x, bottemPent[0].y, bottemPent[0].z);
        vertex(bottemPent[1].x, bottemPent[1].y, bottemPent[1].z);
        endShape(CLOSE);

        beginShape();
        vertex(bottemPent[1].x, bottemPent[1].y, bottemPent[1].z);
        vertex(topPent[i].x, topPent[i].y, topPent[i].z);
        vertex(topPent[0].x, topPent[0].y, topPent[0].z);
        endShape(CLOSE);
      }
    }
  }
}
