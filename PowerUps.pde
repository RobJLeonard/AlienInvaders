class PowerUp
{
  float xpos;
  float ypos;
  PImage powerUp;
  
  PowerUp(int x, int y, PImage powerUpImage)
  {
    xpos = x;
    ypos = y;
    powerUp = powerUpImage;   
  }
  
  void move()
  {
    ypos+=4;
  }
  
  boolean isOnScreen()
  {
    return (ypos>SCREENY);
  }
  
  
  void collide(Player tp)
  {
       if ( ypos + powerUp.height >= tp.ypos && ypos <= tp.ypos+tp.playerImage.height 
       && xpos + powerUp.width > tp.xpos && xpos < tp.xpos + tp.playerImage.width)
      {
        collected = true;
        System.out.println("collected");
      }
  }
  

  
  
  void draw()
  {
    if(collected)
    {
      return;
    }
    else
    {
    image(powerUp, xpos, ypos);
    return;
    }
  }
  
  
}