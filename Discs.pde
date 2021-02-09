class Disc
{
  int mS;
  int mH =10, mW = 50;
  color mDiscC;
  
  Disc(int s, int [] rgb)
  {
    mS = s;
    mDiscC = color(rgb[0], rgb[1], rgb[2]);
  }
  
  void draw(int x, int y)
  {
    fill(mDiscC);
    rect(x, y, mW+10*mS, mH);
  }
}
