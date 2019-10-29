class VerletBall {

  PVector pos, posOld;

  VerletBall() {
  }

  VerletBall(PVector pos) {
    this.pos = pos;
    this.posOld  = new PVector(pos.x, pos.y, pos.z);
  }

  void verlet() {
    PVector posTemp = new PVector(pos.x, pos.y, pos.z);
    pos.x += (pos.x-posOld.x);
    pos.y += (pos.y-posOld.y);
    pos.z += (pos.z-posOld.z);
    posOld.set(posTemp);
  }
}

