class Inst2 extends Instrument{
  int beats = 16; //number of beats before this instrument loops
  int loopSize = beats * 8; //number of steps in one loop
  int currentStep = 0;
  final int MAX_NOTES = 30;
  final float NOTE_SIZE = 150;
  int numNotes = 0;
  
  float baseFreq = 55;
  
  float vol = 0.5;
  float attack = 0.2;
  float sustain = 0.5;
  float sustainLvl = 0.8;
  float release = 2;
  final float MAX_ENV_TIME = 4;
  final float MAX_VOL = 0.5;
  
  Screen instScreen;
  InstStep[] instSteps = new InstStep[128];
  IntList lastAddedAt = new IntList(); //the step that the most recent note was added at
  
  
  Inst2(BeatBox soundBox){
    super(soundBox);
    baseFreq = soundBox.defaultPitch/4;
    myName = "inst2";
    screens.add(new Screen(soundBox, "inst2", 4, 58, 992, 690, HELPER.DARK_GREEN, 4, 3)); //border screen
    screens.add(new Screen(soundBox, "inst2", 8, 62, 1000 - 92, 76, HELPER.BLACK, 4, 3)); //beats slider screen on top
    screens.add(new Screen(soundBox, "inst2", 8, 142, 300, 750 - 148, HELPER.BLACK, 4, 3)); //ADSR sliders
    instScreen = new Screen(soundBox, "inst2", 312, 142, 680, 750 - 148, HELPER.BLACK, HELPER.WHITE, 4, 3); //THE screen
    
    buttons.add(new Button(222, 100, 40, new Color(32, 32, 192), new Color(32, 32, 128))); //clear button
    buttons.add(new Button(172, 100, 40, new Color(192, 32, 32), new Color(128, 32, 32))); //undo button
    
    sliders.add(new Slider(270, 100, 600, true, 1, new Color(255, 255, 30))); //beat length slider
    sliders.add(new Slider(38, 726, 520, false, 0.2)); //A
    sliders.add(new Slider(79, 726, 520, false, 0.5)); //D
    sliders.add(new Slider(120, 726, 520, false, sustainLvl)); //S
    sliders.add(new Slider(161, 726, 520, false, 0.5)); //R
    sliders.add(new Slider(254, 726, 520, false, vol, HELPER.GREEN)); //Volume
    
    for (int i = 0 ; i < instSteps.length ; ++i){
      instSteps[i] = new InstStep(soundBox);
    }
    
    attack =     map(sq(sliders.get(1).val), 0, 1, 0, MAX_ENV_TIME);
    sustain =    map(sq(sliders.get(2).val), 0, 1, 0, MAX_ENV_TIME);
    sustainLvl = map(sq(sliders.get(3).val), 0, 1, 0, 1);
    release =    map(sq(sliders.get(4).val), 0, 1, 0, MAX_ENV_TIME);
    for (int i = 0 ; i < instSteps.length ; ++i){
      instSteps[i].changeEnv(attack, sustain, sustainLvl, release);
    }
      
    vol = MAX_VOL * sliders.get(5).val;
    
    addDefaultNotes();
  }
  
  void myPrint(){
    printDefault();
    instScreen.myPrint();
    stroke(195, 195, 195);
    strokeWeight(1);
    int curLine = 0;
    for (float h = instScreen.y + instScreen.h ; h >= instScreen.y ; h -= instScreen.h/24){
      if (curLine == 7 || curLine == 12 || curLine == 19)
        strokeWeight(4);
      else
        strokeWeight(1);
      line(instScreen.x, h, instScreen.x + instScreen.w, h);
      ++curLine;
    }
    strokeWeight(3);
    float curX =instScreen.x + instScreen.w/2;
    line(curX, instScreen.y, curX, instScreen.y + instScreen.h);
    //print everything on top of instScreen;
    for (int i = 0 ; i < loopSize ; ++i){
      instSteps[i].myPrint();
    }
    
    //print the info about current beat and total beats
    fill(0, 0, 0);
    textSize(32);
    int currentBeat = currentStep/8 + 1;
    text(currentBeat + " | " + beats, 22, 113);
    
    //print for ASDR and V
    text("A  D  S  R       V", 28, 184);
    
    //print U and C on the buttons
    textSize(16);
    fill(230, 230, 230);
    text("C", 216, 106);
    text("U", 166, 106);
  }
  
  void run(){ //runs all the logic for this instrument. Updates variables, etc.
    currentStep = APPLET.step % loopSize;
    updateVars(); //updates variables based on sliders. Only needs to do this when mouse is pressed.
    
    if (APPLET.trigger){
      instSteps[currentStep].play();
    }
  }
  
  void updateVars(){
    //beats = //update this based on the slider for beats
    //loopSize = beats * 8;
    //attack = //update this based on slider for attack
    //...
    //release = //slider 
    if (sliders.get(0).grabbed){
      beats = floor(map(sliders.get(0).val, 0, 1, 1, 17 - 0.001));
      loopSize = beats*8;
    }else if (sliders.get(1).grabbed || sliders.get(2).grabbed || sliders.get(3).grabbed || sliders.get(4).grabbed){
      attack =     map(sq(sliders.get(1).val), 0, 1, 0, MAX_ENV_TIME);
      sustain =    map(sq(sliders.get(2).val), 0, 1, 0, MAX_ENV_TIME);
      sustainLvl = map(sq(sliders.get(3).val), 0, 1, 0, 1);
      release =    map(sq(sliders.get(4).val), 0, 1, 0, MAX_ENV_TIME);
      for (int i = 0 ; i < instSteps.length ; ++i){
        instSteps[i].changeEnv(attack, sustain, sustainLvl, release);
      }
    }else if (sliders.get(5).grabbed){
      vol = MAX_VOL * sliders.get(5).val + 0.001;
    }
  }
  
  float calcFreq(int offset){ //frequency of a note that is 'offset' notes away from the base frequency
    return baseFreq * pow(2, 1.0*offset / 12);
  }
  
  
  //INPUT
  void pressed(float x, float y){ //called when this instrument is selected and it has been pressed in
    if (isVisible()){
      for (int i = 0 ; i < buttons.size() ; ++i){
        buttons.get(i).pressed(x, y);
      }
      for (int i = 0 ; i < sliders.size() ; ++i){
        sliders.get(i).pressed(x, y);
      }
      
    }
  }
  
  void released(float x, float y){ //Doesn't matter if still visible: you still released from that instrument
    
    if (buttons.get(0).down){
      for (int i = 0 ; i < instSteps.length ; ++i){
        instSteps[i].myClear();
      }
      numNotes = 0;
      lastAddedAt.clear();
    }if (buttons.get(1).down){
      removeLastNote();
    }
      
    
    for (int i = 0 ; i < buttons.size() ; ++i){
        buttons.get(i).released();
    }
    for (int i = 0 ; i < sliders.size() ; ++i){
        sliders.get(i).released();
    }
    
    if (instScreen.clickedOn(x, y)){ //clicked on the note creator
      addNote(currentStep, x, y);
    }else if (screens.get(2).clickedOn(x, y)){ //clicked on the ASDR slides
    }
  }
  //END INPUT
  
  void addNote(int step, float x, float y){
    int noteOffset = floor(24 - 24*instScreen.percentHeight(y));
    float freq = calcFreq(noteOffset);
    float size = NOTE_SIZE * vol;

      
    addNote(step, freq, vol, size, x, y);
  }
  
  void addNote(int step, float freq, float vol, float size, float x, float y){          
    if (numNotes < MAX_NOTES){
      float pan = 2 * instScreen.percentWidth(x) - 1;
      
      Color bodyColor = new Color(floor(map(abs(pan), 0, 1, 0, 255)),
                                  floor(random(256)), 
                                  floor(map(x, instScreen.y, instScreen.y + instScreen.h, 0, 255)));
      Color borderColor = HELPER.BLACK;
      
      instSteps[step].makeNote(new NoteSquare(new SawOsc(APPLET), //DEFAULT OSCILLATOR TYPE: This one is set to SinOsc
        freq, vol*masterVolume, pan, new SmartEnv(APPLET, attack, sustain, sustainLvl, release),
        x, y, size, bodyColor, borderColor));
        
      lastAddedAt.append(step);
      ++numNotes;
    }
  }
  
  void removeLastNote(){
    if (lastAddedAt.size() != 0){
      int theStep = lastAddedAt.remove(lastAddedAt.size() - 1);
      instSteps[theStep].removeLast();
      
      --numNotes;
    }
  }
  
  void setMasterVolume(float volIn){
    masterVolume = volIn;
    for (int i = 0 ; i < instSteps.length ; ++i){
      instSteps[i].setMasterVolume(volIn);
    }
  }
  
  void addDefaultNotes(){
    //312, 142, 680, 750 - 148,
    int x = 312;
    int y = 142;
    int w = 680;
    int h = 750 - 148;
    
    addNote(0 * 8 + 1, x + w/2 + -32, y + h - 0*(h/24) - 10);
    addNote(0 * 8 + 2, x + w/2 + 40, y + h - 4*(h/24) - 10);
    addNote(0 * 8 + 3, x + w/2 + -80, y + h - 7*(h/24) - 10);
    addNote(0 * 8 + 3, x + w/2 + 65, y + h - 14*(h/24) - 10);
    
    addNote(4 * 8 + 1, x + w/2 + 24, y + h - 5*(h/24) - 10);
    addNote(4 * 8 + 2, x + w/2 - 80, y + h - 9*(h/24) - 10);
    addNote(4 * 8 + 0, x + w/2 + 110, y + h - 12*(h/24) - 10);
    addNote(4 * 8 + 0, x + w/2 + 68, y + h - 16*(h/24) - 10);
    
    addNote(8 * 8 + 1, x + w/2 + -32, y + h - 0*(h/24) - 10);
    addNote(8 * 8 + 2, x + w/2 + 40, y + h - 4*(h/24) - 10);
    addNote(8 * 8 + 3, x + w/2 + -80, y + h - 7*(h/24) - 10);
    addNote(8 * 8 + 3, x + w/2 + 65, y + h - 14*(h/24) - 10);
    
    addNote(12 * 8 + 1, x + w/2 + 24, y + h - 5*(h/24) - 10);
    addNote(12 * 8 + 2, x + w/2 - 80, y + h - 9*(h/24) - 10);
    addNote(12 * 8 + 0, x + w/2 + 110, y + h - 12*(h/24) - 10);
    addNote(12 * 8 + 1, x + w/2 + 68, y + h - 11*(h/24) - 10);
  }
}
