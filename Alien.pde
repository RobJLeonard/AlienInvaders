PImage alien;
PImage deadAlien;
PImage changedAlien;

class Alien {
  int x;
  int y;
  PImage alien;
  int i = 0;
  int xVel =1;
  int yVel =1;
  float wave;
  float yWave;
  int timer;
  int death = 10;
  int dropped = 0;
  float ang;
  boolean remove = false;
  boolean dead = false;
  boolean changed = false;
  boolean moveRight = true;
  boolean moveDownR = false;
  boolean moveDownL = false;
  boolean moveLeft = false;
  

  /* Constructor is passed the x and y position where the alien is to
   be created, plus the image to be used to draw the alien */

  Alien(int xpos, int ypos, PImage alienImage, PImage explosion, PImage changed)
  {

    x = xpos; 
    y = ypos;
    alien = alienImage;
    deadAlien = explosion;
    changedAlien = changed;
  }
  
  void setup()
  {
    
    
  }

  void move()
  {
    if (!dead)
    {
      if (moveRight)
      {        
        x = x + xVel;
        yWave = y + sin(ang/10)*50;
        ang+=2;
        if (x+alienImage.width >= SCREENX-MARGIN)
        {
          fastinvader1.play();
          moveDownR = true;
          moveRight = false;
        }
      }

      if (moveDownR)
      {
        i = i + yVel;
        y = y + yVel;
        yWave = y + sin(ang/10)*50;
        ang+=2;
        if ( i >= alienImage.height*1.5)
        {
          fastinvader1.play();
          moveDownR = false;
          moveLeft = true;
          i = 0;
          xVel = xVel+1;
          yVel = yVel+1;
        }
      }
      if (moveDownL)
      {
        i= i + yVel;
        y = y + yVel;
        yWave = y + sin(ang/10)*50;
        ang+=2;
        if ( i >= alienImage.height*1.5)
        {
          fastinvader1.play();
          moveDownL = false;
          moveRight = true;
          i = 0;
          xVel = xVel+1;
          yVel = yVel+1;
        }
      }


      if (moveLeft)
      {
        x = x - xVel;
        yWave = y + sin(ang/10)*50;
        ang+=2;
        if (x <= MARGIN)
        {
          
          moveDownL = true;
          moveLeft = false;
        }
      }
    }
  }

  void setFuse(int fuse)
  {
    timer = fuse;
  }

  void explode(boolean hit)
  {
    if (hit)
    {     
      dead = true;
      bombChance*=1.008;
    }
  }
  
  boolean dropPowerUp ()
  {
    boolean drop = false;
    if(Math.random()<=POWERUPCHANCE && dropped < 1)
    {
     dropped++;
     drop = true;
    }
    return drop;  
  }

  void change()
  {
    timer--;
    if (timer >= 22*60 && timer <= 22.5*60)
    {
      changed = true;
    }
  }


  void draw()
  {

    if (death <=0)
      return;
    if (dead) 
    {
      death--;
      image(deadAlien, x, y); 
      return;
    }
    if (changed)
    {
      image(changedAlien, x, yWave);
      return;
    }
    image(alien, x, y);
  }
}