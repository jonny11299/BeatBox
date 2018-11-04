class Tab extends Screen{
  
   Tab(BeatBox appletIn, String tab, float x, float y, float w, float h){
    super(appletIn, tab, x, y, w, h);
  }
  
  Tab(BeatBox appletIn, String tab, float x, float y, float w, float h, Color borderColor){
    super(appletIn, tab, x, y, w, h, borderColor);
  }
  
  Tab(BeatBox appletIn, String tab, float x, float y, float w, float h, Color borderColor, float borderWidth, float rounding){
    super(appletIn, tab, x, y, w, h, borderColor, borderWidth, rounding);
  }
  
  boolean isVisible(){
    return true;
  }
  
}
