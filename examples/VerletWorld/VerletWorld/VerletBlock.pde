class VerletBlock extends VerletObj {

  PVector sz;

  VerletBlock() {
  }

  VerletBlock(PVector sz, float stiffness) {
    super(stiffness);
    balls = new VerletBall[8];
    sphereDetail(3);
    this.sz = sz;

    // top balls
    balls[0] = new VerletBall(new PVector(-sz.x/2, -sz.y/2, sz.z/2)); //LF
    balls[1] = new VerletBall(new PVector(sz.x/2, -sz.y/2, sz.z/2)); //RF
    balls[2] = new VerletBall(new PVector(sz.x/2, -sz.y/2, -sz.z/2)); //RB
    balls[3] = new VerletBall(new PVector(-sz.x/2, -sz.y/2, -sz.z/2)); //LB

    // bottom balls
    balls[4] = new VerletBall(new PVector(-sz.x/2, sz.y/2, sz.z/2)); //LF
    balls[5] = new VerletBall(new PVector(sz.x/2, sz.y/2, sz.z/2)); //RF
    balls[6] = new VerletBall(new PVector(sz.x/2, sz.y/2, -sz.z/2)); //RB
    balls[7] = new VerletBall(new PVector(-sz.x/2, sz.y/2, -sz.z/2)); //LB

    // sticks
    // top
    sticks.add(new VerletStick(balls[0], balls[1], stiffness, true));
    sticks.add(new VerletStick(balls[1], balls[2], stiffness, true));
    sticks.add(new VerletStick(balls[2], balls[3], stiffness, true));
    sticks.add(new VerletStick(balls[3], balls[0], stiffness, true));
    //crosses
    sticks.add(new VerletStick(balls[0], balls[2], stiffness, false));

    //bottom
    sticks.add(new VerletStick(balls[4], balls[5], stiffness, true));
    sticks.add(new VerletStick(balls[5], balls[6], stiffness, true));
    sticks.add(new VerletStick(balls[6], balls[7], stiffness, true));
    sticks.add(new VerletStick(balls[7], balls[4], stiffness, true));
    //crosses
    sticks.add(new VerletStick(balls[4], balls[6], stiffness, false));

    // vertical rails
    sticks.add(new VerletStick(balls[0], balls[4], stiffness, true));
    sticks.add(new VerletStick(balls[1], balls[5], stiffness, true));
    sticks.add(new VerletStick(balls[2], balls[6], stiffness, true));
    sticks.add(new VerletStick(balls[3], balls[7], stiffness, true));

    // diagnols
    sticks.add(new VerletStick(balls[0], balls[6], stiffness, false));
    sticks.add(new VerletStick(balls[1], balls[7], stiffness, false));
    sticks.add(new VerletStick(balls[2], balls[4], stiffness, false));
    sticks.add(new VerletStick(balls[5], balls[3], stiffness, false));

    // side crosses
    sticks.add(new VerletStick(balls[3], balls[4], stiffness, false));
    sticks.add(new VerletStick(balls[1], balls[6], stiffness, false));
  }

  void display() {

    noFill();
    beginShape();
    for (VerletBall b : balls) {
      pushMatrix();
      translate(b.pos.x, b.pos.y, b.pos.z);
      stroke(255, 75);
      box(5);
      popMatrix();
    }


    
    strokeWeight(.75);
    stroke(185, 135, 130);
    for (VerletStick s : sticks) {
      s.display();
    }
  }
}

