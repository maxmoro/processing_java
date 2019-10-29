public class Tendril{
  // Initial path
  private Vector3D[] path;
  // Vectors between path nodes
  public Vector3D[] regVecs;
  // Cage polygons
  Polygon3D[] polys;
  private float xzAng, yzAng, xyAng;
  private float tempX, tempY, tempZ;
  private Vector3D worldOrigin = new Vector3D(0.0f,0.0f,0.0f);
  // Number of points on cage polygons
  private int polyDetail;
  // Tendril thickness
  private float polyRadius;

  private float polyCounter = 0.0;

  public Tendril(Vector3D[] path, int polyDetail, float polyRadius){
    this.path = path;
    this.polyDetail = polyDetail;
    this.polyRadius = polyRadius;
    init();
  }

  private void update(Vector3D[] path){
    this.path = path;
    init();
  }

  private void init(){
    float bulgeAng = 0;
    regVecs = new Vector3D[path.length-1];
    polys = new Polygon3D[path.length-1];
    // generate vectors between each point on path
    for (int i=1; i<path.length; i+=1) {
      regVecs[i-1] = new Vector3D(path[i].x-path[i-1].x, path[i].y-path[i-1].y, path[i].z-path[i-1].z);
    }

    // 1. Calculate angles of rotation of path vectors in
    // reference to y and z-axes. 
    // 2. Use these values to transform vectors to 
    // orthogonal orientation.
    for (int i=0; i<regVecs.length; i++) {
      // Rotate around y-axis
      xzAng = atan2(regVecs[i].x, regVecs[i].z); // need this angle later
      tempZ = (float)(Math.cos(-xzAng+PI/2) * regVecs[i].z - Math.sin(-xzAng+PI/2) * regVecs[i].x);
      tempX = (float)(Math.sin(-xzAng+PI/2) * regVecs[i].z + Math.cos(-xzAng+PI/2) * regVecs[i].x);
      regVecs[i].z = tempZ;
      regVecs[i].x = tempX;

      // Rotate around z-axis
      xyAng = atan2(regVecs[i].y, regVecs[i].x); // need this angle later
      tempX = (float)(Math.cos(-xyAng) * regVecs[i].x - Math.sin(-xyAng) * regVecs[i].y);
      tempY = (float)(Math.sin(-xyAng) * regVecs[i].x + Math.cos(-xyAng) * regVecs[i].y);
      regVecs[i].x = tempX;
      regVecs[i].y = tempY;

      // 1. Construct polygons at world origin with same othogonal 
      // orientation as transformed vectors above.
      // (orientation is parallel to x-axis)
      // 2. Translate polygons back to original positions.
      // if (i<100){


     // polys[i] = new Polygon3D(worldOrigin, polyDetail, polyRadius*1.5+sin(bulgeAng+=.15)*(polyRadius/2), IGConsts.X_AXIS);
      polys[i] = new Polygon3D(worldOrigin, polyDetail, polyRadius, IGConsts.X_AXIS);
      polys[i].init();


      // Reverse order of vector rotations for
      // polygons. This order should mirror 
      // order of original sequence of rotations
      // e.g. AB = BA).
      for (int j=0; j<polys[i].vecs.length; j++){
        // Reverse Z-axis rotation by inverting 
        // theta (xzAng to -xzAxg) and use this value
        // to rotate polygons.
        tempX = (float)(Math.cos(xyAng) * polys[i].vecs[j].x - Math.sin(xyAng) * polys[i].vecs[j].y);
        tempY = (float)(Math.sin(xyAng) * polys[i].vecs[j].x + Math.cos(xyAng) * polys[i].vecs[j].y);
        polys[i].vecs[j].x = tempX;
        polys[i].vecs[j].y = tempY;

        // Reverse Y-axis rotation by inverting 
        // theta (-xzAng+PI/2 to xzAng-PI/2) and use this value
        // to rotate polygons. 
        tempZ = (float)(Math.cos(xzAng-PI/2) * polys[i].vecs[j].z - Math.sin(xzAng-PI/2) * polys[i].vecs[j].x);
        tempX = (float)(Math.sin(xzAng-PI/2) * polys[i].vecs[j].z + Math.cos(xzAng-PI/2) * polys[i].vecs[j].x);
        polys[i].vecs[j].z = tempZ;
        polys[i].vecs[j].x = tempX;

        // translate polygons back to original positions
        polys[i].vecs[j].add(path[i]);
      }
    }
  }

  public void create(int renderDetail, float dynamicCounter){
    switch(renderDetail){
    case IGConsts.RENDER_PATH:
      drawPath();
      break;
    case IGConsts.RENDER_CAGE:
      drawCage();
      break;
    case IGConsts.RENDER_SKIN:
      drawSkin();
      break;
    case IGConsts.RENDER_PATH_DYNAMIC:
      animatePath(dynamicCounter);
      break;
    case IGConsts.RENDER_CAGE_DYNAMIC:
      animateCage(dynamicCounter);
      break;
    case IGConsts.RENDER_SKIN_DYNAMIC:
      animateSkin(dynamicCounter);
      break;
    default:
      drawSkin();
    }
  }

  private void drawPath(){
    noFill();
    beginShape();
    for (int i=1; i<polys.length; i+=1){
      vertex(path[i].x, path[i].y, path[i].z);
    }
    endShape();
  }

  private void drawCage(){
    for (int i=1; i<polys.length; i+=1){
      polys[i].create();
    }
  }

  private void drawSkin(){
    for (int i=1; i<polys.length; i+=1){
      for (int j=1; j<polys[i].vecs.length; j++){
        beginShape(QUADS);
        vertex(polys[i-1].vecs[j-1].x, polys[i-1].vecs[j-1].y, polys[i-1].vecs[j-1].z);
        vertex(polys[i].vecs[j-1].x, polys[i].vecs[j-1].y, polys[i].vecs[j-1].z);
        vertex(polys[i].vecs[j].x, polys[i].vecs[j].y, polys[i].vecs[j].z);
        vertex(polys[i-1].vecs[j].x, polys[i-1].vecs[j].y, polys[i-1].vecs[j].z);
        endShape();
        // close tube
        if (j==polys[i].vecs.length-1){
          beginShape(QUADS);
          vertex(polys[i-1].vecs[j].x, polys[i-1].vecs[j].y, polys[i-1].vecs[j].z);
          vertex(polys[i].vecs[j].x, polys[i].vecs[j].y, polys[i].vecs[j].z);
          vertex(polys[i].vecs[0].x, polys[i].vecs[0].y, polys[i].vecs[0].z);
          vertex(polys[i-1].vecs[0].x, polys[i-1].vecs[0].y, polys[i-1].vecs[0].z);
          endShape();
        }
      }
    }
  }

  private void animatePath(float dynamicCounter){
    noFill();
    beginShape();
    for (int i=0; i<polyCounter; i++) {
      vertex(path[i].x, path[i].y, path[i].z);
    }
    endShape();
    if (polyCounter<polys.length-.1){
      polyCounter+=dynamicCounter;
    }
  }

  private void animateCage(float dynamicCounter){
    for (int i=0; i<polyCounter; i+=1){
      polys[i].create();
    }
    if (polyCounter<polys.length-.1){
      polyCounter+=dynamicCounter;
    }
  }

  private void animateSkin(float dynamicCounter){
    for (int i=1; i<polyCounter; i+=1){
      for (int j=1; j<polys[i].vecs.length; j++){
        beginShape(QUADS);
        vertex(polys[i-1].vecs[j-1].x, polys[i-1].vecs[j-1].y, polys[i-1].vecs[j-1].z);
        vertex(polys[i].vecs[j-1].x, polys[i].vecs[j-1].y, polys[i].vecs[j-1].z);
        vertex(polys[i].vecs[j].x, polys[i].vecs[j].y, polys[i].vecs[j].z);
        vertex(polys[i-1].vecs[j].x, polys[i-1].vecs[j].y, polys[i-1].vecs[j].z);
        endShape();
        // close tube
        if (j==polys[i].vecs.length-1){
          beginShape(QUADS);
          vertex(polys[i-1].vecs[j].x, polys[i-1].vecs[j].y, polys[i-1].vecs[j].z);
          vertex(polys[i].vecs[j].x, polys[i].vecs[j].y, polys[i].vecs[j].z);
          vertex(polys[i].vecs[0].x, polys[i].vecs[0].y, polys[i].vecs[0].z);
          vertex(polys[i-1].vecs[0].x, polys[i-1].vecs[0].y, polys[i-1].vecs[0].z);
          endShape();
        }
      }
    }
    if (polyCounter<polys.length-.1){
     polyCounter+=dynamicCounter;
    }
  }
}
