ArrayList<Object2D> myObjects;

void settings()
{
  size(500, 500);
  myObjects = new ArrayList<Object2D>();
  for(int i = 0; i < 20; i++)
  {
    int number = int(random(100) % 4);
    Object2D o = null;
    switch(number)
    {
      case 0:
        o = new RectObject();
        break;
      case 1:
        o = new CircleObject();
        break;
      case 2:
        o = new StarObject();
        break;
        case 3:
        o = new TriangleObject();
        break;
    }
    o.setPosition(new PVector(random(500), random(500)));
    if(o instanceof Hoverable)
    {
      ((Hoverable)o).setBoundingBox(50, 50);
    }
    
    
    myObjects.add(o);
        
  }
}

void draw()
{
  background(200);
  for(Object2D o : myObjects)
  {
    if(o instanceof Hoverable)
    {
      ((Hoverable)o).checkHovering();
    }
    o.render();
  }
}

void mouseClicked()
{
  for(Object2D o : myObjects)
  {
    if(o instanceof Hoverable)
    {
      ((Hoverable)o).checkSelection();
    }
  }
}
