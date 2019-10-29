class VerletSpider extends VerletObj {
  int legs;
  int joints;
  float radius;
  float bodyRadius = 6;
  float legGap = 0.0;

  VerletSpider() {
  }

  VerletSpider(int legs, int joints, float radius, float stiffness) {
    super(stiffness);
    this.legs = legs;
    this.joints = joints;
    this.radius = radius;
    balls = new VerletBall[legs*(joints-1)+1];

    float theta = 0.0;
    legGap = radius/joints;
    // lead node
    balls[0] = new VerletBall(new PVector(0, 0, 0));
    for (int i=0, k=0; i<legs; i++) {
      for (int j=1; j<joints; j++) {
        k = i*(joints-1)+j;
        //println(k);
        balls[k] = new VerletBall(new PVector(bodyRadius+cos(theta)*legGap*j, bodyRadius+sin(theta)*legGap*j, 0));
        if (j==1) {
          sticks.add(new VerletStick(balls[0], balls[k], stiffness, true));
        } else {
          sticks.add(new VerletStick(balls[k-1], balls[k], stiffness, true));
        }
      }
      theta += TWO_PI/legs;
    }
  }

  void display() {
    strokeWeight(2.75);
    stroke(255, 195, 255);
    for (VerletStick s : sticks) {
      s.display();
    }

    //body
    strokeWeight(1.75);
    pushMatrix();
    translate(balls[0].pos.x, balls[0].pos.y, balls[0].pos.z);
    stroke(175, 195, 175);
    fill(#aabbcc);
    sphere(legGap);
    popMatrix();

    strokeWeight(1.75);
    for (int i=0; i<balls.length; i++) {
      pushMatrix();
      translate(balls[i].pos.x, balls[i].pos.y, balls[i].pos.z);
      fill(125, 135, 190, 25);
      ellipse(0, 0, 7, 7);
      popMatrix();
    }
  }
}

