class Shield
{
  
  float xpos;
  float ypos;
  boolean destroyed = false;
  
  Shield(float x, float y)
  {
    xpos = x;
    ypos = y;
    
  }
  
  void explode(boolean hit)
  {
    if(hit)
    {
      destroyed = true;
    } 
  }
  
  void draw()
  {
    if(!destroyed)
    {
    fill(0,0,255);
    noStroke();
    rect(xpos, ypos, SHIELDWIDTH, SHIELDHEIGHT);
    }
  }
  
  
}