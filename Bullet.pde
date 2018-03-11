class Bullet
{
  float  xpos; 
  float  ypos;
  float ang;
  color  bulletColor  =  color(20, 200, 60);  

  Bullet(float playerPos)  
  {  
    xpos=playerPos+PLAYERWIDTH/2;  
    ypos=SCREENY-PLAYERHEIGHT;
  }  

  void move()
  {
    if(collected)
    {
      ypos-=15;
     // xpos= xpos + sin(ang/10)*10;
      ang+=5;
    }
    else
    {
    ypos-=5;
    }
  }

  boolean collide(Alien a)
  {
    boolean hit = false;
    if (ypos + BULLETHEIGHT >= a.y && ypos <= a.y+a.alien.height && xpos + BULLETWIDTH > a.x && xpos < a.x + a.alien.width)
    {
      hit = true;
      invaderkilled.play();
      System.out.println(hit);
    } else
    {
      hit = false;
      System.out.println(hit);
    }
    return hit;
  }
  
    boolean collide(Shield s)
  {
    boolean hit = false;
    if (ypos + BULLETHEIGHT >= s.ypos && ypos <= s.ypos+SHIELDHEIGHT && xpos + BULLETWIDTH > s.xpos && xpos < s.xpos + SHIELDWIDTH && !s.destroyed)
    {
      hit = true;
      explosionSound.play();
      xpos = SCREENX + 200;
      System.out.println(hit);
    } else
    {
      hit = false;
      System.out.println(hit);
    }
    return hit;
  }
  
   boolean collideP (PowerUp a)
  {
    boolean hit = false;

    if (xpos > a.xpos-20 && ypos < a.ypos + a.powerUp.height && xpos < a.xpos+20 && ypos+20 > a.ypos)
    {
      hit = true;
      System.out.println(hit);
    } else
    {
      hit = false;
      System.out.println(hit);
    }
    return hit;
  }



  void draw()
  {
    fill(bulletColor);
    if(collected)
    {
      rect(xpos-20, ypos, BULLETWIDTH, BULLETHEIGHT);
      rect(xpos+20, ypos, BULLETWIDTH, BULLETHEIGHT);
    }
    else
    rect(xpos, ypos, BULLETWIDTH, BULLETHEIGHT);
    
    
  }
}