class Node3D extends Cube{
  float x, y, z;
  Shape3D shape;

   Node3D(Shape3D shape, Dimension3D d){
    super(d);
  }
  
  Node3D(Dimension3D d, float x, float y, float z){
    super(d);
    this.x = x;
    this.y = y;
    this.z = z;
  }
}
