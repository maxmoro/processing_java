class VerletRay extends VerletObj {
  int joints;
  float radius;

  VerletRay() {
  }

  VerletRay(int joints, float radius, float stiffness) {
    super(stiffness);
    this.joints = joints;
    this.radius = radius;
    balls = new VerletBall[joints];

    float theta = 0.0;
    float randomDepth = random(-200, -50);
    for (int i=0; i<joints; i++) {
      balls[i] = new VerletBall(new PVector(cos(theta)*radius, sin(theta)*radius, randomDepth));
      theta += TWO_PI/joints;
    }

    for (int i=0; i<joints; i++) {
      if (i < joints-1) {
        sticks.add(new VerletStick(balls[i], balls[i+1], stiffness, true));
      } else {
        sticks.add(new VerletStick(balls[i], balls[0], stiffness, true));
      }
      if (i < joints/2) {
        sticks.add(new VerletStick(balls[i], balls[i+joints/2], stiffness, true));
      }
    }
  }

  void display() {
//    fill(105, 75, 105, 15);
//    beginShape();
//    for (VerletBall b : balls) {
//      curveVertex(b.pos.x, b.pos.y, b.pos.z);
//    }
//    endShape(CLOSE);

    strokeWeight(.75);
    stroke(195, 155, 195);
    for (VerletStick s : sticks) {
      s.display();
    }
  }
}

