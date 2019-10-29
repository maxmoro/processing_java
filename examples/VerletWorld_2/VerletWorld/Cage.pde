class Cage {

  PVector span;

  Cage() {
  }

  Cage(PVector span) {
    this.span = span;
  }

  void display() {
    noFill();
    strokeWeight(1.5);
    stroke(255, 245, 245);
    box(span.x, span.y, span.z);
  }
}

