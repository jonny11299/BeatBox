import processing.sound.*;

class SmartEnv
{
  Env env;
  
  public float a; //attack time
  public float s; //sustain time
  public float lvl; //sustain lvl
  public float r; //release time
  
  float amp; //amplitude at current moment
  int lastPlayed = -10000000; //last time this oscillator has been played, in ms
  
  
  
  SmartEnv(BeatBox app, float attackTime, float sustainTime, float sustainLevel, float releaseTime){
    a = attackTime;
    s = sustainTime;
    lvl = sustainLevel;
    r = releaseTime;
    env = new Env(app);
  }
  
  void play(Oscillator osc){
    env.play(osc, a, s, lvl, r);
    lastPlayed = BeatBox.clock;
  }
  
  
  float getAmp(){ //gets the amplitude at the current moment based on last time played, float value from 0 to 1.0
                  //always reaches 1 at the peak of attack, no matter how loud the note is being played
    float t = (1.0 * BeatBox.clock - 1.0 * lastPlayed)/1000; //t is time since played, in seconds
    if (t < a){  //in attack phase
      return t/a;
    }else if (t < a + s){ //in sustain phase
      float x = map(t, a, a + s, 0, 1); //x maps (end of a, end of s) to (0 - 1)
      return map(sq(1 - x), 0, 1, lvl, 1);
    }else if (t < a + s + r){ //in release phase
      float x = map(t, a + s, a + s + r, 0, 1);
      return map(sq(1 - x), 0, 1, 0, lvl);
    }else{
      return 0;
    }
  }
  
  boolean done(){ //returns true if the note has finished playing
    float t = (1.0 * BeatBox.clock - 1.0 * lastPlayed)/1000; //t is time since played, in seconds
    return t > a + s + r;
  }
  
}
