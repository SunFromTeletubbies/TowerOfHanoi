class Game
{
  int mN;
  Tower mA, mB, mC;
  ArrayList<Movement> mMoveSeq;
  int mCurrentMoveIdx = 0;
  int mAge = 0;
  float mSpeed, mFFSpeed;
  float mInrS, mInrF;
  float mInr;
  int mTowerBaseY = height/2+125;
  boolean mPaused;
  boolean mFastForward;
  boolean mFinished;
  boolean mToggleFF;
  color mTowerBaseC = color(169,169,169);
  
  Game(int n)
  {
    mN = n;
    if(mN<0)
    {mN = 0;}
    init();
  }
  
  void init()
  {
    mSpeed = initialMovesPerSecond;
    mFFSpeed = initialFastForwardMovesPerSecond;
    mInrS = maxSpeed/mSpeed;
    mInrF = maxSpeed/mFFSpeed;
    mA = new Tower(1*width/4-20, height/2+10);
    mB = new Tower(2*width/4, height/2+10);
    mC = new Tower(3*width/4+20, height/2+10);
    for(int i = 0; i<mN; i++)
    {
      float waveLength = map(i, 0, mN-1, 400, 650);
      int [] colorRGB = waveLengthToRGB(waveLength);
      Disc d = new Disc(mN-i, colorRGB);
      mA.mDs.add(i, d);
    }
    mMoveSeq = new ArrayList(0);
    play(mN, mA, mB, mC);
  }
  
  void play(int n, Tower a, Tower b, Tower c)
  {
    if(n>0)
    {
      play(n-1, a, c, b);
      Movement newMoveSeq = new Movement(a, c);
      mMoveSeq.add(mMoveSeq.size(), newMoveSeq);
      play(n-1, b, a, c);
    }
  }
    
  void move(Tower from, Tower to)
  {
    Disc movedDisc = topDisc(from);
    from.mDs.remove(movedDisc);
    to.mDs.add(movedDisc);
  }
  
  Disc topDisc(Tower t) 
  {
    return t.mDs.get(t.mDs.size()-1);
  }
  
  void draw()
  {
    background(255);
    mA.draw();
    mB.draw();
    mC.draw();
    fill(mTowerBaseC);
    rect(width/2, mTowerBaseY, 560, 20);
    textAlign(CENTER, CENTER);
    textSize(15);
    fill(0);
    text("Moves performed: " + mCurrentMoveIdx, width/2, height/6);
    text("Number of discs: " + mN, width/2, height/6-30);
    if(mFinished)
    {
      text("Done!",width/2, height/6+30);
    }
    else if(mPaused)
    {
      text("Paused",width/2, height/6+30);
    }
    else if(mToggleFF)
    {
      text("Fast-forward speed: x" + int(mFFSpeed) + " (Toggled)",width/2, height/6+30);
    }
    else if(mFastForward)
    {
      text("Fast-forward speed: x" + int(mFFSpeed),width/2, height/6+30);
    }
    else 
    {
      text("Speed: x" + int(mSpeed),width/2, height/6+30);
    }
  
  }
  
  void run()
  {
    animate();
  }
  
  void animate()
  {  
    mInrS = maxSpeed/mSpeed;
    mInrF = maxSpeed/mFFSpeed;
    if(mousePressed || mToggleFF)
    {
      mInr=mInrF; 
      mFastForward = true;
    }
    else
    { 
      mInr=mInrS; 
      mFastForward = false;
    }
    if(mCurrentMoveIdx>mMoveSeq.size()-1)
    {
      mFinished = true;
    }
        
    if(!mPaused && !mFinished)
    {
      mAge+=1;
      if(mAge%mInr==0)
      {
        if(mMoveSeq.size()>0)
        {
          Movement currentMoveSeq = mMoveSeq.get(mCurrentMoveIdx);
          move(currentMoveSeq.mFrom, currentMoveSeq.mTo);
          mCurrentMoveIdx +=1;
        }
      }
    }
    draw();
  }
}
  
