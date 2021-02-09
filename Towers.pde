class Tower
{
  int mX, mY;
  int mH = 230, mW = 25;
  ArrayList<Disc> mDs;
  color mTowersC = color(211,211,211);
  
  Tower(int x, int y)
  {
    mX = x; mY = y;
    mDs = new ArrayList(0);
  }
  
  void draw()
  {
    fill(mTowersC);
    rectMode(CENTER);
    rect(mX, mY, mW, mH);
    drawDiscs();
  }
  
  void drawDiscs()
  {
    rectMode(CENTER);
    for(int i = mDs.size()-1; i>=0; i--)
    {
      mDs.get(i).draw(mX, mY-mDs.get(i).mH*(i)+100);
    }
  }
}
