//A way to chunkate the main screen into several smaller sub-screens.

class Screen{
  String myTab = "none"; //the tab that this screen is shown in
  BeatBox APPLET;
  
  float x; //x coordinate of top left corner
  float y; //y coordinate of top left corner
  float w; //screen's width
  float h; //screen's height
  float borderWidth = 2;
  float rounding = 1; //default screen rounding
  
  Color borderColor = new Color(0, 0, 0);
  Color backgroundColor = new Color(200, 200, 200);
  
  Screen(BeatBox appletIn, String tab, float x, float y, float w, float h){
    APPLET = appletIn;
    myTab = tab;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  Screen(BeatBox appletIn, String tab, float x, float y, float w, float h, Color borderColor){
    APPLET = appletIn;
    myTab = tab;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.borderColor = borderColor;
  }
  
  Screen(BeatBox appletIn, String tab, float x, float y, float w, float h, Color borderColor, float borderWidth, float rounding){
    APPLET = appletIn;
    myTab = tab;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.borderColor = borderColor;
    this.borderWidth = borderWidth;
    this.rounding = rounding;
  }
  Screen(BeatBox appletIn, String tab, float x, float y, float w, float h, Color borderColor, Color backgroundColor, float borderWidth, float rounding){
    APPLET = appletIn;
    myTab = tab;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.borderColor = borderColor;
    this.backgroundColor = backgroundColor;
    this.borderWidth = borderWidth;
    this.rounding = rounding;
  }
  
  boolean isVisible(){ //returns true if the tab selected is the tab that this screen is within
    return myTab == APPLET.currentTab;
  }
  
  boolean clickedOn(float xIn, float yIn){
    return isVisible() && x <= xIn && xIn <= x + w && y <= yIn && yIn <= y + h;
  }
  
  void myPrint(){
    fill(backgroundColor.r, backgroundColor.g, backgroundColor.b);
    stroke(borderColor.r, borderColor.g, borderColor.b);
    strokeWeight(borderWidth);
    rect(x, y, w, h, rounding);
  }
  
  float percentHeight(float yIn){ //returns a value from 0 to 1 based on the location this screen was pressed
    if (yIn > y + h) return 1;
    if (yIn < y) return 0;
    return map(yIn, y, y + h, 0, 1);
  }
  float percentWidth(float xIn){
    if (xIn > x + w) return 1;
    if (xIn < x) return 0;
    return map(xIn, x, x + w, 0, 1);
  }
}
