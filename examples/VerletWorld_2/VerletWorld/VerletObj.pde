abstract class VerletObj {

  VerletBall[] balls;
  ArrayList<VerletStick> sticks = new ArrayList<VerletStick>();
  float stiffness;

  VerletObj() {
  }

  VerletObj(float stiffness) {
    this.stiffness = stiffness;
  }



  void push(PVector push) {
    balls[0].pos.add(push);
  }


  void verlet() {
    for (VerletBall b : balls) {
      b.verlet();
    }

    for (VerletStick s : sticks) {
      s.constrainLen();
    }

    collide();
  }

  void collide() {
    float jolt = 3.0;
    for (VerletBall b : balls) {
      if (b.pos.x > width/2) {
        b.pos.x = width/2;
        b.pos.x -= jolt;
      } else if (b.pos.x < -width/2) {
        b.pos.x = -width/2;
        b.pos.x += jolt;
      }

      if (b.pos.y > height/2) {
        b.pos.y = height/2;
        b.pos.y -= jolt;
      } else if (b.pos.y < -height/2) {
        b.pos.y = -height/2;
        b.pos.y += jolt;
      }

      if (b.pos.z > 250) {
        b.pos.z = 250;
        b.pos.z -= jolt;
      } else if (b.pos.z < -250) {
        b.pos.z = -250;
        b.pos.z += jolt;
      }
    }
  }
}

