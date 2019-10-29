class RectButton extends Component {
  PFont font;

  RectButton(){
  }
  
  RectButton(PVector position, Dimension dimension, 
  String label, color[] states) {
    super(position, dimension, label, states);
    font = loadFont("ArialMT-22.vlw");
    textFont(font, 15);
  }

  boolean isHit() {
    if (mouseX >= position.x && mouseX <= position.x + dimension.w &&
      mouseY >= position.y && mouseY <= position.y + dimension.h) {
      return true;
    }
    return false;
  }

  void display() {
    if (hasBorder) {
      stroke(100);
    } else {
      noStroke();
    }
    fill(labelCol);
    rect(position.x, position.y, dimension.w, dimension.h);

    fill(labelTextCol);
    float tw = textWidth(label);
    textAlign(LEFT, CENTER);
    text(label, position.x +(dimension.w-tw)/2.0, position.y + dimension.h/2);
  }
}

