class Vec2 {
  float x, y;

  Vec2() {
  }
  Vec2(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class VerletStick {

  VerletBall b1, b2;
  float stiffness;

  PVector vecOrig;
  float len;
  Vec2 bias;
  boolean isVisible;

  VerletStick() {
  }

  VerletStick(VerletBall b1, VerletBall b2, float stiffness, boolean isVisible) {
    this.b1 = b1;
    this.b2 = b2;
    this.stiffness = stiffness;
    bias = new Vec2(.5, .5);
    this.isVisible = isVisible;
    vecOrig  = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y, b2.pos.z-b1.pos.z);
    len = dist(b1.pos.x, b1.pos.y, b1.pos.z, b2.pos.x, b2.pos.y, b2.pos.z);
  }

  VerletStick(VerletBall b1, VerletBall b2, float stiffness, Vec2 bias, boolean isVisible) {
    this.b1 = b1;
    this.b2 = b2;
    this.stiffness = stiffness;
    this.bias = bias;
    this.isVisible = isVisible;
    vecOrig  = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y, b2.pos.z-b1.pos.z);
    len = dist(b1.pos.x, b1.pos.y, b1.pos.z, b2.pos.x, b2.pos.y, b2.pos.z);
  }


  // constrainVal needs to be changed for anchors
  void constrainLen() {
    for (int i=0; i<2; i++) {
      PVector delta = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y, b2.pos.z-b1.pos.z);
      float deltaLength = delta.mag();
      float difference = ((deltaLength - len) / deltaLength);
      b1.pos.x += delta.x * (bias.x * stiffness * difference);
      b1.pos.y += delta.y * (bias.x * stiffness * difference);
      b1.pos.z += delta.z * (bias.x * stiffness * difference);
      b2.pos.x -= delta.x * (bias.y * stiffness * difference);
      b2.pos.y -= delta.y * (bias.y * stiffness * difference);
      b2.pos.z -= delta.z * (bias.y * stiffness * difference);
    }
  }



  void display() {
    if (isVisible) {
//      beginShape();
//      vertex(b1.pos.x, b1.pos.y, b1.pos.z);
//      //curveVertex(b1.pos.x, b1.pos.y, b1.pos.z);
//      //curveVertex(b2.pos.x, b2.pos.y, b2.pos.z);
//      vertex(b2.pos.x, b2.pos.y, b2.pos.z);
//      endShape();
      line(b1.pos.x, b1.pos.y, b1.pos.z, b2.pos.x, b2.pos.y, b2.pos.z);
    }
  }
}

