// Custom Cube class
class Cube extends Shape3D{
  Vector3D[] vertices = new Vector3D[8];
  int sides = 6;

  // Constructors
  // default constructor
  Cube(){
  }
  // constructor 2
  Cube(Dimension3D dim){
   super(dim);
    init();
  }
  // constructor 3
  Cube(float w, float h, float d){
    super(new Dimension3D(w, h, d));
    init();
  }
   
  // cube composed of 6 quads from 8 points
  void init(){
    //front
    vertices[0] = new Vector3D(-w/2,-h/2,d/2);
    vertices[1] = new Vector3D(w/2,-h/2,d/2);
    vertices[2] = new Vector3D(w/2,h/2,d/2);
    vertices[3] = new Vector3D(-w/2,h/2,d/2);
    //back
    vertices[4] = new Vector3D(-w/2,-h/2,-d/2);
    vertices[5] = new Vector3D(w/2,-h/2,-d/2);
    vertices[6] = new Vector3D(w/2,h/2,-d/2);
    vertices[7] = new Vector3D(-w/2,h/2,-d/2);
  }

  void create(){
    // build all quads clockwise

      // front
    beginShape(QUADS);
    vertex(x+vertices[0].x, y+vertices[0].y, z+vertices[0].z);
    vertex(x+vertices[1].x, y+vertices[1].y, z+vertices[1].z);
    vertex(x+vertices[2].x, y+vertices[2].y, z+vertices[2].z);
    vertex(x+vertices[3].x, y+vertices[3].y, z+vertices[3].z);
    endShape();

    // left
    beginShape(QUADS);
    vertex(x+vertices[4].x, y+vertices[4].y, z+vertices[4].z);
    vertex(x+vertices[0].x, y+vertices[0].y, z+vertices[0].z);
    vertex(x+vertices[3].x, y+vertices[3].y, z+vertices[3].z);
    vertex(x+vertices[7].x, y+vertices[7].y, z+vertices[7].z);
    endShape();

    //back
    beginShape(QUADS);
    vertex(x+vertices[5].x, y+vertices[5].y, z+vertices[5].z);
    vertex(x+vertices[4].x, y+vertices[4].y, z+vertices[4].z);
    vertex(x+vertices[7].x, y+vertices[7].y, z+vertices[7].z);
    vertex(x+vertices[6].x, y+vertices[6].y, z+vertices[6].z);
    endShape();

    // right
    beginShape(QUADS);
    vertex(x+vertices[1].x, y+vertices[1].y, z+vertices[1].z);
    vertex(x+vertices[5].x, y+vertices[5].y, z+vertices[5].z);
    vertex(x+vertices[6].x, y+vertices[6].y, z+vertices[6].z);
    vertex(x+vertices[2].x, y+vertices[2].y, z+vertices[2].z);
    endShape();

    // top
    beginShape(QUADS);
    vertex(x+vertices[4].x, y+vertices[4].y, z+vertices[4].z);
    vertex(x+vertices[5].x, y+vertices[5].y, z+vertices[5].z);
    vertex(x+vertices[1].x, y+vertices[1].y, z+vertices[1].z);
    vertex(x+vertices[0].x, y+vertices[0].y, z+vertices[0].z);
    endShape();

    // bottom
    beginShape(QUADS);
    vertex(x+vertices[3].x, y+vertices[3].y, z+vertices[3].z);
    vertex(x+vertices[2].x, y+vertices[2].y, z+vertices[2].z);
    vertex(x+vertices[6].x, y+vertices[6].y, z+vertices[6].z);
    vertex(x+vertices[7].x, y+vertices[7].y, z+vertices[7].z);
    endShape();
  }
}
