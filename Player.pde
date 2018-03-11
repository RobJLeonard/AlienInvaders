class Player
{
  int    wins;
  int    losses;
  float  xpos; 
  float  ypos; 
  float  dxPlayer;
  PImage playerImage;
  float  oldPosition=0;
  color  playerColor  =  color(20,200,60);  
 
  Player(PImage spaceship)  
  {  
    playerImage = spaceship;
    xpos=SCREENX/2;  
    ypos=SCREENY-PLAYERHEIGHT;
  }  
  
  void move(int  x) 
  {  
    if (x>SCREENX-spaceship.width)  
    xpos  =  SCREENX-spaceship.width;  
    else  
    xpos=x;
  } 


  void  draw()  
  {  
    fill(playerColor);  
    image(spaceship, xpos, ypos);
  }
}