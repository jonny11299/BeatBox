class Instrument{
  BeatBox APPLET;
  ArrayList<Screen> screens = new ArrayList<Screen>(); //background is screens[0]
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Slider> sliders = new ArrayList<Slider>();
  String myName = "instrument";
  
  float masterVolume = 0.5;
  
  Instrument(BeatBox soundBox){
    APPLET = soundBox;
  }
  
  void printDefault(){
    for (int i = 0 ; i < screens.size() ; ++i){
      screens.get(i).myPrint();
    }
    for (int i = 0 ; i < buttons.size() ; ++i){
      buttons.get(i).myPrint();
    }
    for (int i = 0 ; i < sliders.size() ; ++i){
      sliders.get(i).myPrint();
    }
  }
  
  boolean isVisible(){
    return APPLET.currentTab == myName;
  }
  
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
    for (int i = 0 ; i < buttons.size() ; ++i){
        buttons.get(i).released();
    }
    for (int i = 0 ; i < sliders.size() ; ++i){
        sliders.get(i).released();
    }
  }
  
  void run(){
  
  }
}
