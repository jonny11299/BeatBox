class Main extends Instrument{
  
  Main(BeatBox soundBox){
    super(soundBox);
    screens.add(new Screen(soundBox, "main", 4, 58, 992, 690, HELPER.RED, 4, 3)); //NEED TO INPUT THE NAME OF THE TAB IT'S VISIBLE UNDER
    screens.add(new Screen(soundBox, "main", 8, 62, 325, 76, HELPER.BLACK, 4, 3)); //buttons
    screens.add(new Screen(soundBox, "main", 8, 142, 325, 76, HELPER.BLACK, 4, 3));//tempo
    screens.add(new Screen(soundBox, "main", 8, 222, 325, 522, HELPER.BLUE, 4, 3)); //inst1's screen
    screens.add(new Screen(soundBox, "main", 336, 222, 327, 522, HELPER.DARK_GREEN, 4, 3)); //inst2's screen
    screens.add(new Screen(soundBox, "main", 666, 222, 325, 522, HELPER.YELLOW, 4, 3)); //inst3's screen
    myName = "main";
    
    buttons.add(new Button(96, 100, 50)); //play button
    buttons.add(new Button(236, 100, 50, new Color(192, 0, 0), new Color(128, 0, 0))); //pause button
    
    sliders.add(new Slider(48, 195, 245, true)); //tempo slider
    sliders.add(new Slider(8 + 277/2 + 20, 720, 420, false, 0.5, new Color(64, 64, 255))); //inst1 slider 
    sliders.add(new Slider(336 + 277/2 + 20, 720, 420, false, 0.5, new Color(64, 255, 64)));  //inst2 slider
    sliders.add(new Slider(666 + 277/2 + 20, 720, 420, false, 0.5, new Color(255, 255, 64)));  //beatMachine slider
  }
  
  void myPrint(){
    printDefault();
    
    stroke(0, 0, 0);
    strokeWeight(4);
    
    if (APPLET.play){ //prints play button
      fill(0, 255, 0);
      triangle(156, 90, 156, 110, 176, 100);
      
    }else{            //prints pause button
      fill(255, 0, 0);
      rect(154, 85, 10, 30);
      rect(169, 85, 10, 30);
    }
    
    
    
    fill(0);
    //text("Clock: " + APPLET.clock, 50, 200);
    //text("Play: " + APPLET.play, 50, 250);
    //text("Played at: " + APPLET.playedAt, 50, 300);
    textSize(16);
    text("Tempo: " + (int) APPLET.tempo, 126, 174);
    //text("Beat: " + APPLET.beat, 50, 400);
    //text("miniBeat: " + APPLET.miniBeat, 50, 450);
  
    textSize(32);
    fill(0, 0, 255);
    text("Triangle", 8 + 98, 260);
    fill(16, 200, 16);
    text("Saw", 336 + 132, 260);
    fill(255, 255, 0);
    text("Beat", 666 + 122, 260);
  }
  
  void run(){
    if (buttons.get(0).down){
      APPLET.play = true;
      APPLET.playedAt = APPLET.clock;
      APPLET.beat = 0;
    }
    if (buttons.get(1).down){
      APPLET.play = false;
    }
    APPLET.tempo = map(sliders.get(0).val, 0, 1, 50, 200);
    
    if (sliders.get(1).grabbed){
      APPLET.inst1.setMasterVolume(sliders.get(1).val);
    }else if (sliders.get(2).grabbed){
      APPLET.inst2.setMasterVolume(sliders.get(2).val);
    }else if (sliders.get(3).grabbed){
      APPLET.beatMachine.setMasterVolume(sliders.get(3).val);
    }
  }
}
