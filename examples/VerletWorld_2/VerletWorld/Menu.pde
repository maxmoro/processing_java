class Menu {

  Layout menuPosition;
  ButtonType buttonType;
  String[] labels;
  color[] states;
  Dimension dimension;
  Component[] buttons;

  Menu() {
  }

  Menu(Layout menuPosition, Dimension dimension, String[] labels, color[] states) {
    this.menuPosition = menuPosition;
    this.dimension = dimension;
    this.labels = labels;
    this.states = states;
    buttons = new Component[labels.length];

    generate();
  }

  Menu(Layout menuPosition, Dimension dimension, String[] labels, color[] states, ButtonType buttonType) {
    this.menuPosition = menuPosition;
    this.dimension = dimension;
    this.labels = labels;
    this.states = states;
    this.buttonType = buttonType;
    buttons = new Component[labels.length];

    generate();
  }


  void generate() {

    float btnW, btnH;
    if (menuPosition == Layout.TOP || menuPosition == Layout.BOTTOM) {
      btnW = dimension.w/buttons.length;
      btnH = dimension.h;
    } else {

      // left or right position
      btnW = dimension.w;
      btnH = dimension.h/buttons.length;
    }

    for (int i=0; i<buttons.length; i++) {
      PVector pos;
      Dimension dim;
      switch (menuPosition) {
      case TOP:
        pos = new PVector(btnW * i, 0);
        dim = new Dimension(btnW, btnH);
        break; 
      case BOTTOM:
        pos = new PVector(btnW * i, height-btnH);
        dim = new Dimension(btnW, btnH); 
        break;
      case LEFT:
        pos = new PVector(0, btnH * i);
        dim = new Dimension(btnW, btnH); 
        break;
      case RIGHT:
        pos = new PVector(width-btnW, btnH * i);
        dim = new Dimension(btnW, btnH); 
        break;
      default: // top
        pos = new PVector(btnW * i, 0);
        dim = new Dimension(btnW, btnH);
      }

      switch (buttonType) {
      case RECT:
        buttons[i] = new RectButton(pos, dim, labels[i], states);
        break;
      case ROUNDED_RECT:
        buttons[i] = new RoundedRectButton(pos, dim, labels[i], states, 6);
        break;
      default:
        buttons[i] = new RectButton(pos, dim, labels[i], states);
      }
    }
  }


  void display() {
    for (int i=0; i<buttons.length; i++) {
      buttons[i].display();
    }

    createMenuEvents();
  }

  void createMenuEvents() {
    for (int i=0; i<buttons.length; i++) {
      // pressed
      if (buttons[i].isHit() && mousePressed) {
        select(i);
        buttons[i].labelCol = states[3];
        // mouse over
      } else if (buttons[i].isHit() && !buttons[i].isSelected) {
        buttons[i].labelCol = states[2];
         buttons[i].labelTextCol = #766676;
        // selected
      } else if (buttons[i].isSelected) {
        buttons[i].labelCol = states[1];
        buttons[i].labelTextCol = #766676;
        // default
      } else {
        buttons[i].labelCol = states[0];
        buttons[i].labelTextCol = #ffffff;
      }
    }
  }
  void select(int isSelectedID) {
    for (int i=0; i<buttons.length; i++) {
      if (i==isSelectedID) {
        buttons[i].isSelected = true;
      } else {
        buttons[i].isSelected = false;
      }
    }
  }

  String getSelected() {
    String btn;
    for (int i=0; i<buttons.length; i++) {
      if (buttons[i].isSelected) {
        return buttons[i].label;
      }
    }
    return "";
  }
}

