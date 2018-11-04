class DrumTrack{
  BeatBox APPLET;
  SoundFile sample;
  DrumBox[] drumBoxes = new DrumBox[64];
  Screen leftSideScreen;
  Slider volumeSlider;
  
  boolean amClicked = false;
  
  float vol;
  
  float x;
  float y;
  float w;
  float h;
  
  float noteWeight = 2;
  float measureWeight = 4;
  
  Color borderColor;
  Color backgroundColor;
  Color filledColor;
  
  DrumTrack(BeatBox appletIn, String fileName, float x, float y, float w, float h, Color borderColor, Color backgroundColor, Color filledColor){
    APPLET = appletIn;
    sample = new SoundFile(APPLET, "samples/" + fileName);
    
    vol = 0.5;
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    this.borderColor = borderColor;
    this.backgroundColor = backgroundColor;
    this.filledColor = filledColor;
    
    leftSideScreen = new Screen(APPLET, "beatMachine", x - 88, y, 86, h, HELPER.BLACK, 4, 3);
    volumeSlider = new Slider(x - 44, y + h - 16, h - 32, false, vol, filledColor);
    
    for (int i = 0 ; i < drumBoxes.length ; ++i){
      float size = 1.0 * drumBoxes.length;
      float xTemp = x + i/size * w; 
      drumBoxes[i] = new DrumBox(APPLET, "beatMachine", xTemp, y, w/size, h, borderColor, backgroundColor, filledColor, sample, i);
    }
  }
  
  void myPrint(){
    for (int i = 0 ; i < drumBoxes.length ; ++i){
      drumBoxes[i].myPrint();
    }
    leftSideScreen.myPrint();
    volumeSlider.myPrint();
    
    //print the harder lines
    stroke(borderColor.r, borderColor.g, borderColor.b);
    for (int i = 0 ; i <= drumBoxes.length ; ++i){
      float size = 1.0 * drumBoxes.length;
      float xTemp = x + i/size * w;
      if (i % 4 == 0){
        if (i % 16 == 0)
          strokeWeight(measureWeight);
        else
          strokeWeight(noteWeight);
        line(xTemp, y, xTemp, y + h);  
      }
    }
    strokeWeight(measureWeight);
    line(x, y+h, x+w, y+h); //fills a line in the bottom just to mkae it look nice
    
  }
  
  void run(){
    if (volumeSlider.grabbed){
      vol = volumeSlider.val;
    }
  }
  
  void trigger(int currentStep, float masterVolume){
    if (!drumBoxes[currentStep].isEmpty()){
      drumBoxes[currentStep].play(vol * masterVolume); //play drumbox based on this track's current volume and volume from master
    }
  }
  
  void myClear(){
    for (int i = 0 ; i < drumBoxes.length ; ++i){
      drumBoxes[i].myClear();
    }
  }
  
  void pressed(float x, float y){
    for (int i = 0 ; i < drumBoxes.length ; ++i){
      drumBoxes[i].pressed(x, y);
    }
    volumeSlider.pressed(x, y);
    if (this.x < x && x < this.x + this.w && this.y < y && y < this.y + this.h)
      amClicked = true;
  }
  void released(float x, float y){
    for (int i = 0 ; i < drumBoxes.length ; ++i){
      drumBoxes[i].released(x, y);
    }
    volumeSlider.released();
    amClicked = false;
  }
  void dragged(float x, float y){
    for (int i = 0 ; i < drumBoxes.length ; ++i){
      if (amClicked) drumBoxes[i].dragged(x, y);
    }
  }
  
  void addDefaultNote(int step, float percentVol){
    drumBoxes[step].val = percentVol;
  }
  
}
