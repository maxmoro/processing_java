class VerletWorm extends VerletObj {

  float len = 175.0;
  int joints = 12;
  float thickness;
  float[] body;

  VerletWorm() {
  }

  VerletWorm(float len, int joints, float stiffness, float thickness) {
    super(stiffness);
    this.len = len;
    this.joints = joints;
    this.thickness = thickness;
    balls = new VerletBall[joints];
    PVector randomBirthPos = new PVector(random(-len/2, len/2), random(-height/2.5, height/2.5), random(-150, 150));
    float randomBodyVector = random(TWO_PI);
    body = new float[joints];
    float bodyGap = PI/joints;
    for (int i=0; i<joints; i++) {
      balls[i] = new VerletBall(new PVector(randomBirthPos.x+cos(randomBodyVector)*i*(len/(joints-1)), 
      randomBirthPos.y+sin(randomBodyVector)*i*(len/(joints-1)), 
      randomBirthPos.z));

      if (i>0) {
        sticks.add(new VerletStick(balls[i-1], balls[i], stiffness, true));
      }
      body[i] = abs(sin(bodyGap*i)*16);
    }
  }

  void display() {
    // spine
    stroke(65, 75, 155);
    strokeWeight(thickness);
    for (VerletStick s : sticks) {
      s.display();
    }
    //body
    stroke(125, 135, 190);
    strokeWeight(.75);
    for (int i=0; i<joints; i++) {
      pushMatrix();
      translate(balls[i].pos.x, balls[i].pos.y, balls[i].pos.z);
      fill(125, 135, 190, 25);
      //noFill();
      ellipse(0, 0, body[i], body[i]);
      popMatrix();
    }
  }
}

