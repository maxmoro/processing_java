abstract class Object2D
{
  protected PVector pos;
  
  public Object2D()
  {
    pos = new PVector(0,0);
  }
  
  public void setPosition(PVector _pos)
  {
    pos = _pos;
  }
  
  protected abstract void createObject();
  
  public void render()
  {
    pushMatrix();
      translate(pos.x, pos.y);
      // Code to actually create the object
      createObject();
    popMatrix();
  }
}
