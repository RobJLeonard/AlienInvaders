import java.util.Arrays; //<>//
import processing.sound.*;

Alien[] aliens;
Player thePlayer;
Bullet[] bullets;
Bomb[] bombs;
PowerUp pUp;
Shield shields[];
PFont font;
int[] f;
PImage bombImage;
PImage alienImage;
PImage spaceship;
PImage explosion;
PImage changed;
PImage powerUpImage;
PImage space;
boolean fired = false;
boolean powerUpOnscreen = false;
boolean gameOver = false;
int bulletCount = 0;
int numberOfChanged = 4;
int reload = 0;
SoundFile shoot;
SoundFile explosionSound;
SoundFile invaderkilled;
SoundFile fastinvader1;
SoundFile music;
SoundFile gameOverMusic;

void settings()
{
  size(SCREENX, SCREENY);
}

void setup() 
{

  noCursor();
  font = createFont("impact.vlw", 100);
  textFont(font);
  textAlign(CENTER);
  shoot = new SoundFile(this, "shoot.wav");
  explosionSound = new SoundFile(this, "explosion.wav");
  invaderkilled = new SoundFile(this, "invaderkilled.wav");
  fastinvader1 = new SoundFile(this, "fastinvader1.wav");
  music = new SoundFile(this, "music.mp3");
  gameOverMusic = new SoundFile(this, "gameOver.mp3");
  bombImage = loadImage("bomb.png");
  bombImage.resize(0, 20);
  spaceship = loadImage("spaceship.png");
  spaceship.resize(0, 40);
  powerUpImage = loadImage("PowerUp.GIF");
  space = loadImage("space.jpg");
  aliens = new Alien[10];
  bombs = new Bomb[aliens.length];
  thePlayer = new Player(spaceship);
  bullets = new Bullet[15];
  shields = new Shield[4*4];
  if (kanyeTime)
  {
    alienImage = loadImage("Kanye Head.png");
    alienImage.resize(0, 80);
    explosion = loadImage("Kanye Head Sad.png");
    explosion.resize(0, 80);
    changed = loadImage("Kanye Head Glasses.png");
    changed.resize(0, 80);
  } else
  {
    alienImage = loadImage("Alien.GIF");
    alienImage.resize(0, 40);
    explosion = loadImage("exploding.GIF");
    explosion.resize(0, 40);
    changed = loadImage("Alien Angry.GIF");
    changed.resize(0, 40);
  }
  init_shields(shields);
  init_aliens(aliens, alienImage);
  setRandomFuse(aliens);
  init_bullets(bullets);
  init_bombs(bombs);
  music.loop();
}
void mousePressed()
{

  if (collected)
  {
    shoot.play();
    bullets[bulletCount] = new Bullet(thePlayer.xpos - (thePlayer.playerImage.width/2 - 20) + BULLETWIDTH );
    shoot.play();
    bullets[bulletCount] = new Bullet(thePlayer.xpos - (thePlayer.playerImage.width/2 + 20) + BULLETWIDTH );
    bulletCount+=2;
  } else
  {
    shoot.play();
    bullets[bulletCount] = new Bullet(thePlayer.xpos - ((thePlayer.playerImage.width/2) + 2*BULLETWIDTH) );
    bulletCount++;
  }

  if (bulletCount>=bullets.length)
    bulletCount = 0;
}


void draw()
{
  background(space);
  thePlayer.move(mouseX);
  thePlayer.draw();
  move_bombs(bombs);
  draw_bombs(bombs);
  move_bullets(bullets);
  draw_bullets(bullets);
  destroy_shield();
  draw_shields(shields);
  move_array(aliens); 
  explode_array();
  dropBomb(aliens);
  dropPowerUP ();
  if (powerUpOnscreen)
  {
    pUp.move();
    pUp.collide(thePlayer);
    pUp.draw();
    if (pUp.isOnScreen())
      powerUpOnscreen = false;
  }
  draw_aliens(aliens);
  sinAlien();
  if (bombCollide(bombs, thePlayer))
  {
    explosionSound.play();
    text("GAME OVER", SCREENX/2, SCREENY/2);
    music.stop();
    gameOverMusic.play();
    noLoop();
  }
  if (aliensDead(aliens))
  {
    text("You Win!", SCREENX/2, SCREENY/2);
    music.stop();
    gameOverMusic.play();
    noLoop();
  }
}

void draw_aliens (Alien aliens[])
{
  for (int  i=0; i<aliens.length; i++) 
  { 
    aliens[i].draw();
  }
}

void  move_array(Alien  aliens[])
{  
  for (int i=0; i<aliens.length; i++) 
  {
    aliens[i].move();
  }
}

void  move_bullets(Bullet  bullets[])
{  
  for (int i=0; i<bullets.length; i++) 
  {
    bullets[i].move();
  }
}


void  draw_bullets(Bullet  bullets[])
{  
  for (int i=0; i<bullets.length; i++) 
  {
    bullets[i].draw();
  }
}


void init_aliens ( Alien aliens[], PImage alienImage)
{
  for ( int i = 0; i<aliens.length; i ++)
  {
    aliens[i] = new Alien(MARGIN + i*alienImage.width, MARGIN, alienImage, explosion, changed);
  }
}

void init_bullets ( Bullet bullets[])
{
  for ( int i = 0; i<bullets.length; i ++)
  {
    bullets[i] = new Bullet(SCREENX + BULLETWIDTH);
  }
}

void init_bombs ( Bomb bombs[])
{
  for ( int i = 0; i<bombs.length; i ++)
  {
    bombs[i] = new Bomb(SCREENX + 20, SCREENY, bombImage);
  }
}

void move_bombs ( Bomb bombs[])
{
  for ( int i = 0; i<bombs.length; i ++)
  {
    bombs[i].move();
  }
}

void draw_bombs ( Bomb bombs[])
{
  for ( int i = 0; i<bombs.length; i ++)
  {
    bombs[i].draw();
  }
}

void draw_shields ( Shield shields[])
{
  for ( int i = 0; i<shields.length; i ++)
  {
    shields[i].draw();
  }
}


void dropPowerUP ()
{
  for ( int i = 0; i<aliens.length; i++)
  {
    if (aliens[i].dead)
    {
      if (aliens[i].dropPowerUp() && !powerUpOnscreen)
      {
        pUp = new PowerUp (aliens[i].x, aliens[i].y, powerUpImage);
        powerUpOnscreen = true;
      }
    }
  }
}

void setRandomFuse (Alien aliens[])
{  
  for (int i = 0; i<aliens.length; i ++)
    aliens[i].setFuse( (int) random(5*60, 30*60));
}

void explode_array()
{
  for ( int i = 0; i<aliens.length; i++)
  {
    for (int j = 0; j<bullets.length; j++)
    {
      aliens[i].explode(bullets[j].collide(aliens[i]));
    }
  }
}

void destroy_shield()
{
  for ( int i = 0; i<shields.length; i++)
  {
    int b = 0;
    for (int j = 0; j<bullets.length; j++)
    {
      if(b>bombs.length-1)
      b=0;
      
      shields[i].explode(bullets[j].collide(shields[i]));
      shields[i].explode(bombs[b].collide(shields[i]));
      b++;
      
    }
  }
}



void dropBomb(Alien aliens[])
{
  for (int i = 0; i<aliens.length; i ++)
  {
    if (Math.random() < bombChance && bombs[i].isOffScreen() && !aliens[i].dead)
    {
      bombs[i] = new Bomb (aliens[i].x, aliens[i].y, bombImage);
    }
  }
}

boolean bombCollide(Bomb bombs[], Player tp)
{  
  boolean hit = false;
  for (int i = 0; i<bombs.length; i++)
  {
    if (bombs[i].collide(tp))
    {
      hit = true;
    }
  }
  return hit;
}


void sinAlien()
{
  for ( int i = 0; i<aliens.length; i ++)
  {
    aliens[i].change();
  }
}

boolean aliensDead(Alien aliens[])
{
  boolean allDead[] = new boolean[aliens.length];
  Arrays.fill(allDead, false);
  for (int i = 0; i<aliens.length; i ++)
  {
    if ( aliens[i].dead )
    {
      allDead[i] = true;
    }
  }   
  for (boolean b : allDead) if (!b) return false;
  return true;
}

void init_shields(Shield shields[])
{
  float xpos = 60;
  float ypos = SCREENY - 180;
  float tempx = xpos;
  int i = 0;
  
    for (int p = 0; p < 4; p++)
    {
      ypos = SCREENY - 180;
      for ( int y = 0; y < 4; y++)
      {
        xpos = tempx;
        for ( int x = 0; x < 1; x++)
        {
          shields[i] = new Shield(xpos, ypos);
          xpos+=SHIELDWIDTH; 
          i++;
        }
        ypos+=SHIELDHEIGHT;
      }
      tempx+= 200;
    }
  
}