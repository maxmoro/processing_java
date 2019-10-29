// Custom Cube class
class Cube{
  Point3D[] vertices = new Point3D[8];
  int sides = 6;
  float w, h, d;

  // Constructors
  // default constructor
  Cube(){
  }
  // constructor 2
  Cube(Dimension3D dim){
    w = dim.w;
    h = dim.h;
    d = dim.d;
    init();
  }
  // constructor 3
  Cube(float w, float h, float d){
    this.w = w;
    this.h = h;
    this.d = d;
    init();
  }
  // cube composed of 6 quads from 8 points
  void init(){
    //front
    vertices[0] = new Point3D(-w/2,-h/2,d/2);
    vertices[1] = new Point3D(w/2,-h/2,d/2);
    vertices[2] = new Point3D(w/2,h/2,d/2);
    vertices[3] = new Point3D(-w/2,h/2,d/2);
    //back
    vertices[4] = new Point3D(-w/2,-h/2,-d/2);
    vertices[5] = new Point3D(w/2,-h/2,-d/2);
    vertices[6] = new Point3D(w/2,h/2,-d/2);
    vertices[7] = new Point3D(-w/2,h/2,-d/2);
  }

  void create(){
    // build all quads clockwise

      // front
    beginShape(QUADS);
    vertex(vertices[0].x, vertices[0].y, vertices[0].z);
    vertex(vertices[1].x, vertices[1].y, vertices[1].z);
    vertex(vertices[2].x, vertices[2].y, vertices[2].z);
    vertex(vertices[3].x, vertices[3].y, vertices[3].z);
    endShape();

    // left
    beginShape(QUADS);
    vertex(vertices[4].x, vertices[4].y, vertices[4].z);
    vertex(vertices[0].x, vertices[0].y, vertices[0].z);
    vertex(vertices[3].x, vertices[3].y, vertices[3].z);
    vertex(vertices[7].x, vertices[7].y, vertices[7].z);
    endShape();

    //back
    beginShape(QUADS);
    vertex(vertices[5].x, vertices[5].y, vertices[5].z);
    vertex(vertices[4].x, vertices[4].y, vertices[4].z);
    vertex(vertices[7].x, vertices[7].y, vertices[7].z);
    vertex(vertices[6].x, vertices[6].y, vertices[6].z);
    endShape();

    // right
    beginShape(QUADS);
    vertex(vertices[1].x, vertices[1].y, vertices[1].z);
    vertex(vertices[5].x, vertices[5].y, vertices[5].z);
    vertex(vertices[6].x, vertices[6].y, vertices[6].z);
    vertex(vertices[2].x, vertices[2].y, vertices[2].z);
    endShape();

    // top
    beginShape(QUADS);
    vertex(vertices[4].x, vertices[4].y, vertices[4].z);
    vertex(vertices[5].x, vertices[5].y, vertices[5].z);
    vertex(vertices[1].x, vertices[1].y, vertices[1].z);
    vertex(vertices[0].x, vertices[0].y, vertices[0].z);
    endShape();

    // bottom
    beginShape(QUADS);
    vertex(vertices[3].x, vertices[3].y, vertices[3].z);
    vertex(vertices[2].x, vertices[2].y, vertices[2].z);
    vertex(vertices[6].x, vertices[6].y, vertices[6].z);
    vertex(vertices[7].x, vertices[7].y, vertices[7].z);
    endShape();
  }
}
