class Polygon3D{

  Vector3D origin = new Vector3D(0, 0, 0);
  int vectorCount = 8;
  float radius = 50;
  Vector3D[] vecs;
  int axisAlignment = IGConsts.X_AXIS;

  Polygon3D(){
    init();
  }

  Polygon3D(Vector3D origin, int vectorCount, float radius, int axisAlignment){
    this.origin = origin;
    this.vectorCount = vectorCount;
    this.radius = radius;
    this.axisAlignment = axisAlignment;
    vecs = new Vector3D[vectorCount];
    init();
  }

  // init geometry
  void init(){
    float px=0, py=0, pz=0, angle=0;
    switch(axisAlignment){
    case IGConsts.X_AXIS:
      px = origin.x;
      pz = origin.z + cos(radians(angle))*radius;
      py = origin.y + sin(radians(angle))*radius;
      vecs[0] =  new Vector3D(px, py, pz);
      angle+=360/vectorCount;
      for (int i=1; i<vectorCount; i++){
        pz = origin.z + cos(radians(angle))*radius;
        py = origin.y + sin(radians(angle))*radius;
        vecs[i] =  new Vector3D(px, py, pz);
        angle+=360/vectorCount;
      }
      break;
    case IGConsts.Y_AXIS:
      py = origin.y;
      px = origin.x + cos(radians(angle))*radius+random(-3, 3);
      pz = origin.z + sin(radians(angle))*radius+random(-3, 3);
      vecs[0] =  new Vector3D(px, py, pz);
      angle+=360/vectorCount;
      for (int i=1; i<vectorCount; i++){
        px = origin.x + cos(radians(angle))*radius+random(-3, 3);
        pz = origin.z + sin(radians(angle))*radius+random(-3, 3);
        vecs[i] =  new Vector3D(px, py, pz);
        angle+=360/vectorCount;
      }
      break;
    case IGConsts.Z_AXIS:
      pz = origin.z;
      px = origin.x + cos(radians(angle))*radius;
      py = origin.y + sin(radians(angle))*radius;
      vecs[0] =  new Vector3D(px, py, pz);
      angle+=360/vectorCount;
      for (int i=1; i<vectorCount; i++){
        px = origin.x + cos(radians(angle))*radius;
        py = origin.y + sin(radians(angle))*radius;
        vecs[i] =  new Vector3D(px, py, pz);
        angle+=360/vectorCount;
      }
      break;
    }
  }

  // draw polys
  void create(){
    beginShape();
    for (int i=0; i<vecs.length; i++){
      vertex(vecs[i].x, vecs[i].y, vecs[i].z);
    }
    endShape(CLOSE);
  }
}
