color bgCol = #ddddff;
Menu menu;
Cage cage;

int blockCount = 155;
VerletBlock[] blockies = new VerletBlock[blockCount];

int wormCount = 40;
VerletWorm[] worms = new VerletWorm[wormCount];

int rayCount = 35;
VerletRay[] rays = new VerletRay[rayCount];

int spiderCount = 15;
VerletSpider[] spiders = new VerletSpider[spiderCount];

void setup() {
  size(1024, 768, P3D);
  cage = new Cage(new PVector(width*1.075, height*1.07, 700));

  String[] labels = {
    "worms", "rays", "blockies", "spiders", "soup"
  };
  color[] states = {
    //offState, onState, overState, pressState
    #eebfbb, bgCol, #eeffef, #ffaa66
  };
  menu = new Menu(Layout.TOP, new Dimension(width, 23), labels, states, ButtonType.RECT);
  //menu = new Menu(Layout.LEFT, new Dimension(65, height/4), labels, states, ButtonType.ROUNDED_RECT);
  //menu = new Menu(Layout.BOTTOM, new Dimension(width, 23), labels, states, ButtonType.RECT);
  //menu = new Menu(Layout.RIGHT, new Dimension(65, height), labels, states, ButtonType.RECT);
  // How to change corner radius through explicit casting. Only use for ButtonType.ROUNDED_RECT
  //RoundedRectButton rb = (RoundedRectButton)(menu.buttons[0]);
  //rb.cornerRadius = 12;

  // blockies
  for (int i=0; i<blockies.length; i++) {
    //VerletBlock(PVector sz, float stiffness)
    float sz = random(20, 55);
    blockies[i] = new VerletBlock(new PVector(sz, sz, sz), random(.003, .1));
    blockies[i].push(new PVector (random(-10.01, 10.01), random(-10.01, 10.01), random(-10.01, 10.01)));
  }

  //worms
  for (int i=0; i<worms.length; i++) {
    //VerletWorm(float len, int joints, float stiffness, float thickness)
    worms[i] = new VerletWorm(random(250, 450), int(random(35, 65)), .7, 2.0);
    worms[i].push(new PVector (random(-30.01, 30.01), random(-30.01, 30.01), random(-30.01, 30.01)));
  }

  // rays
  for (int i=0; i<rays.length; i++) {
    //VerletRay(int joints, float radius, float stiffness)
    rays[i] = new VerletRay(38, random(15, 65), random(.03, .3));
    rays[i].push(new PVector (random(-30.01, 30.01), random(-30.01, 30.01), random(-30.01, 30.01)));
  }

  // spiders
  for (int i=0; i<spiders.length; i++) {
    //VerletSpider(int legs, int joints, float radius, float stiffness)
    spiders[i] = new VerletSpider(int(random(6, 16)), int(random(6, 16)), random(75, 125), random(.03, .3));
    spiders[i].push(new PVector (random(-100.01, 100.01), random(-100.01, 100.01), random(-100.01, 100.01)));
  }
}

void draw() {
  background(bgCol);

  menu.display();

  translate(width/2, height/2, -250);
  rotateY(frameCount*PI/680);
  //rotateX(frameCount*PI/280);
  //rotateZ(frameCount*PI/580);
  cage.display();


  if (menu.getSelected() == "blockies") {
    for (VerletBlock b : blockies) {
      b.verlet();
      b.display();
    }
  } else if (menu.getSelected() == "worms") {
    for (VerletWorm s : worms) {
      s.verlet();
      s.display();
    }
  } else if (menu.getSelected() == "rays") {
    for (VerletRay r : rays) {
      r.verlet();
      r.display();
    }
  } else if (menu.getSelected() == "spiders") {
    for (int i=0; i< spiders.length; i++) {
      spiders[i].verlet();
      spiders[i].display();
    }
  } else if (menu.getSelected() == "soup") {
    for (int i=0; i<worms.length*.5; i++) {
      worms[i].verlet();
      worms[i].display();
    }
    for (int i=0; i<rays.length*.5; i++) {
      rays[i].verlet();
      rays[i].display();
    }
    for (int i=0; i<blockies.length*.5; i++) {
      blockies[i].verlet();
      blockies[i].display();
    }
    for (int i=0; i<spiders.length*.5; i++) {
      spiders[i].verlet();
      spiders[i].display();
    }
  }
}

