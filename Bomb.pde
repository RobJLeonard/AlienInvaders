class Bomb
{
  float xpos;
  float ypos;
  PImage bomb;
  
  Bomb(float x, float y, PImage bombImage)
  {
    xpos=x;  
    ypos=y;
    bomb = bombImage;
  }
  
  void move()
  {
   ypos+=4; 
  }
  
  boolean collide(Player tp)
  {  
    boolean collided = false;
    
    if( ypos + bomb.height >= tp.ypos && ypos <= tp.ypos+tp.playerImage.height && xpos + bomb.width > tp.xpos && xpos < tp.xpos + tp.playerImage.width)
    {
        collided = true;
    }
    
    return collided;
  }
  
   boolean collide(Shield s)
  {
    boolean hit = false;
    if (ypos + BULLETHEIGHT >= s.ypos && ypos <= s.ypos+SHIELDHEIGHT && xpos + BULLETWIDTH > s.xpos && xpos < s.xpos + SHIELDWIDTH && !s.destroyed)
    {
      hit = true;
      explosionSound.play();
      xpos = SCREENX;
      System.out.println(hit);
    } else
    {
      hit = false;
      System.out.println(hit);
    }
    return hit;
  }
  
  
  boolean isOffScreen()
  {
    return (ypos > SCREENY);
  }
  
  
  void draw()
  {
    image(bomb, xpos, ypos);
  }
  
  
}
  
  