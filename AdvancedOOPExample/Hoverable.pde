abstract class Hoverable extends Object2D
{
  protected boolean hovered;
  protected boolean selected;
  protected int boxWidth;
  protected int boxHeight;
  
  public void setBoundingBox(int _w, int _h)
  {
    boxWidth = _w;
    boxHeight = _h;
  }
  
  public void checkHovering()
  {
    hovered = false; //<>//
    if(mouseX >= pos.x && mouseX <= pos.x + boxWidth &&
      mouseY >= pos.y && mouseY <= pos.y + boxHeight)
      {
        hovered = true;
      }
  }
  
  public void checkSelection()
  {
    if(hovered)
      selected = !selected;
  }
  
  public void colorObject()
  {
    if(hovered)
    {
      if(selected)
      {
        fill(0, 255, 0);
      }
      else
      {
        fill(200);
      }
    }
    else if(selected)
    {
      fill(255, 0, 0);
    }
    else
    {
      fill(255);
    }
  }
}
