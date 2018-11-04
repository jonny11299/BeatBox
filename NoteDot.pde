//a dot that plays a note.

class NoteDot{
  Oscillator osc;
  SmartEnv env;
  Color c;
  Color bc; //border color
  
  float x;
  float y;
  float size = 300; //the size of this dot when played at max volume
  
  float freq;
  float vol;
  float masterVol = 0.5;
  float pan;
  
  NoteDot(Oscillator oscIn, float freq, float volume, SmartEnv envIn, float xIn, float yIn){
    osc = oscIn;
    env = envIn;
    
    x = xIn;
    y = yIn;
    c = HELPER.randomColor();
    this.freq = freq;
    this.vol = volume;
    
  }
  
  NoteDot(Oscillator oscIn, float freq, float volume, float pan, SmartEnv envIn, float xIn, float yIn, float sizeIn, Color cIn, Color bcIn){
    osc = oscIn;
    env = envIn;
    
    x = xIn;
    y = yIn;
    size = sizeIn;
    c = cIn;
    bc = bcIn;
    this.freq = freq;
    this.vol = volume;
    this.pan = pan;
    
  }
  
  void play(){
    osc.play(freq, vol*masterVol, 0, pan);
    env.play(osc);
  }
  
  void myPrint(){
    stroke(bc.r, bc.g, bc.g);
    strokeWeight(1);
    fill(c.r, c.g, c.b);
    float r = sqrt(sq(size) * env.getAmp());
    ellipse(x, y, r, r);
  }
  
  boolean done(){ //returns true when the envelope is done playing
    return env.done();
  }
  
  void setMasterVolume(float volIn){
    masterVol = volIn;
  }
}
