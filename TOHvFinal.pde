/* The goal of the game is to move all of the discs from the first tower to the third without placing any larger discs on smaller ones

   Keep the number of discs 12 or less
   Press space to pause
   Press mouse to fast-forward
   Press "f" to toggle fast-forward
   Use the UP and DOWN arrow keys to adjust the speed of the animation
   Use the UP and DOWN arrow keys while pressing mouse to adjust the speed of the animation in fast forward
   Keep initialFastForwardMovesPerSecond a multiple of 32 and greater or equal to 32
   
   For n discs, the least possible number of moves is 2^n-1*/

Game game;
final int numberOfDiscs = 10;
float initialMovesPerSecond = 1; 
float initialFastForwardMovesPerSecond = 64;
int maxSpeed = 256;

void setup()
{
  size(600, 600);
  game = new Game(numberOfDiscs);
  frameRate(maxSpeed);
  if(initialMovesPerSecond<1)
  {
    initialMovesPerSecond = 1;
  }
  if(initialFastForwardMovesPerSecond<32)
  {
    initialFastForwardMovesPerSecond = 32;
  }
  game.init();
}

void draw()
{
  game.run();
} 

void keyPressed()
{
  if(key == ' ')
  {
    game.mPaused = !game.mPaused;
  }
  else if(key == 'f' || key == 'F')
  {
    game.mToggleFF = !game.mToggleFF;
  }
  else if((!mousePressed && !game.mToggleFF) && keyCode == UP && game.mSpeed<16)
  {
    game.mSpeed*=2;
  }
  else if((!mousePressed && !game.mToggleFF) && keyCode == DOWN && game.mSpeed>1)
  {
    game.mSpeed/=2;
  }
  else if((mousePressed || game.mToggleFF) && keyCode == UP && game.mFFSpeed<maxSpeed)
  {
    game.mFFSpeed*=2;
  }
  else if((mousePressed || game.mToggleFF) && keyCode == DOWN && game.mFFSpeed>32)
  {
    game.mFFSpeed/=2;
  }
}
