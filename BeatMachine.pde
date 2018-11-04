class BeatMachine extends Instrument{
  int beats = 8; //number of beats before this instrument loops
  int loopSize = beats * 4; //number of steps in one loop
  int currentStep = 0;
  boolean beatTrigger; //is true when the first arrived upon a new beat
  
  ArrayList<DrumTrack> drumTracks = new ArrayList<DrumTrack>();
  
  BeatMachine(BeatBox soundBox){
    super(soundBox);
    myName = "beatMachine";
    screens.add(new Screen(soundBox, "beatMachine", 4, 58, 992, 690, HELPER.YELLOW, 4, 3)); //NEED TO INPUT THE NAME OF THE TAB IT'S VISIBLE UNDER
    screens.add(new Screen(soundBox, "beatMachine", 4, 58, 992, 690, HELPER.YELLOW, 4, 3)); //border screen
    screens.add(new Screen(soundBox, "beatMachine", 8, 62, 1000 - 92, 76, HELPER.BLACK, 4, 3)); //beats slider screen on top
    
    buttons.add(new Button(222, 100, 40, new Color(32, 32, 192), new Color(32, 32, 128))); //clear button
    
    sliders.add(new Slider(270, 100, 600, true, 0.25, new Color(255, 255, 30))); //beat length slider
    
    float remainingHeight = 746 - 144; //the height that is left over for drum tracks
    float drumTrackX = 96;
    drumTracks.add(new DrumTrack(APPLET, "hihatOpen808.wav", drumTrackX, 140, 896, remainingHeight/4, HELPER.BLACK, new Color(196, 196, 64), HELPER.YELLOW));
    drumTracks.add(new DrumTrack(APPLET, "hihat808.wav", drumTrackX, 140 + remainingHeight/4, 896, remainingHeight/4, HELPER.BLACK, new Color(196, 196, 64), HELPER.YELLOW));
    drumTracks.add(new DrumTrack(APPLET, "snare808.wav", drumTrackX, 140 + 2*remainingHeight/4, 896, remainingHeight/4, HELPER.BLACK, new Color(196, 196, 64), HELPER.YELLOW));
    drumTracks.add(new DrumTrack(APPLET, "kick808.wav", drumTrackX, 140 + 3*remainingHeight/4, 896, remainingHeight/4, HELPER.BLACK, new Color(196, 196, 64), HELPER.YELLOW));
    
    addDefaultNotes();
  }
  
  void myPrint(){
    printDefault();
    
    for (int i = 0 ; i < drumTracks.size() ; ++i){
      drumTracks.get(i).myPrint();
    }
    
    //print the info about current beat and total beats
    fill(0, 0, 0);
    textSize(32);
    int currentBeat = currentStep/4 + 1;
    text(currentBeat + " | " + beats, 22, 113);
    
    //print U and C on the buttons
    textSize(16);
    fill(230, 230, 230);
    text("C", 216, 106);
    
    //prints translucent shade over notes that don't get played
    fill(128, 128, 128, 128);
    rect(992, 140, - drumTracks.get(0).w * (16 - beats) / 16, 746 - 144);
    
    //prints the stepper over notes
    fill(255, 255, 255, 64);
    strokeWeight(2);
    rect(96 + currentStep * 896/64, 140, 896/64, 746 - 144);
  }
  
  void run(){ //runs all the logic for this instrument. Updates variables, etc.
    int newStep = APPLET.step/2 % loopSize;
    if (newStep != currentStep) //we have reached a new step
      beatTrigger = true;
    else
      beatTrigger = false;
    currentStep = newStep;
    
    if (sliders.get(0).grabbed){
      beats = floor(map(sliders.get(0).val, 0, 1, 1, 17 - 0.001));
      loopSize = beats*4;
    }
    
    if (buttons.get(0).down){
      for (int i = 0 ; i < drumTracks.size() ; ++i){
        drumTracks.get(i).myClear();
      }
    }
    
    for (int i = 0 ; i < drumTracks.size() ; ++i){
      drumTracks.get(i).run();
      if (beatTrigger)
        drumTracks.get(i).trigger(currentStep, masterVolume);
    }
  }
  
  
  void setMasterVolume(float volIn){
    masterVolume = volIn;
  }
  
  void pressed(float x, float y){ //called when this instrument is selected and it has been pressed in
    if (isVisible()){
      for (int i = 0 ; i < buttons.size() ; ++i){
        buttons.get(i).pressed(x, y);
      }
      for (int i = 0 ; i < sliders.size() ; ++i){
        sliders.get(i).pressed(x, y);
      }
      for (int i = 0 ; i < drumTracks.size() ; ++i){
        drumTracks.get(i).pressed(x, y);
      }
    }
  }
  
  void released(float x, float y){ //Doesn't matter if still visible: you still released from that instrument
    for (int i = 0 ; i < buttons.size() ; ++i){
        buttons.get(i).released();
    }
    for (int i = 0 ; i < sliders.size() ; ++i){
        sliders.get(i).released();
    }
    for (int i = 0 ; i < drumTracks.size() ; ++i){
      drumTracks.get(i).released(x, y);
    }
  }
  void dragged(float x, float y){ 
    for (int i = 0 ; i < drumTracks.size() ; ++i){
      drumTracks.get(i).dragged(x, y);
    }
  }
  
  
  void addDefaultNotes(){
    drumTracks.get(3).addDefaultNote(0, 0.8);
    drumTracks.get(3).addDefaultNote(14, 0.5);
    drumTracks.get(3).addDefaultNote(16, 0.8);
    
    drumTracks.get(2).addDefaultNote(8, 0.9);
    drumTracks.get(2).addDefaultNote(24, 0.9);
    
    drumTracks.get(1).addDefaultNote(4, 0.7);
    drumTracks.get(1).addDefaultNote(12, 0.7);
    drumTracks.get(1).addDefaultNote(20, 0.7);
    drumTracks.get(1).addDefaultNote(28, 0.7);
    
    drumTracks.get(0).addDefaultNote(14, 0.3);
  }
}
