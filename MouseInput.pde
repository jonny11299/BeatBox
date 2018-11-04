class MouseInput{
  
  
  MouseInput(){}
 
  
  
  void pressed(BeatBox APPLET, float x, float y){
    if (APPLET.mainTab.clickedOn(x, y)){
      APPLET.currentTab = "main";
    }else if (APPLET.inst1Tab.clickedOn(x, y)){
      APPLET.currentTab = "inst1";
    }else if (APPLET.inst2Tab.clickedOn(x, y)){
      APPLET.currentTab = "inst2";
    }else if (APPLET.beatMachineTab.clickedOn(x, y)){
      APPLET.currentTab = "beatMachine";
    }else{
      APPLET.main.pressed(x, y);
      APPLET.inst1.pressed(x, y);
      APPLET.inst2.pressed(x, y);
      APPLET.beatMachine.pressed(x, y);
    }
  }
  void released(BeatBox APPLET, float x, float y){
      APPLET.main.released(x, y);
      APPLET.inst1.released(x, y);
      APPLET.inst2.released(x, y);
      APPLET.beatMachine.released(x, y);
  }
  void clicked(BeatBox APPLET, float x, float y){
    
  }
  void dragged(BeatBox APPLET, float x, float y){
    APPLET.beatMachine.dragged(x, y);
  }
}
