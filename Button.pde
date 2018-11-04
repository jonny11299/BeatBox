class Button{
  Color clickedColor = new Color(0, 192, 0);
  Color unclickedColor = new Color(0, 128, 0);
  Color borderColor = new Color(0, 0, 0);
  float borderWidth = 2;
  public boolean down = false;
  
  float x;
  float y;
  float r;
  
  Button(float x, float y, float r){
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  Button(float x, float y, float r, Color clicked, Color unclicked){
    this.x = x;
    this.y = y;
    this.r = r;
    clickedColor = clicked;
    unclickedColor = unclicked;
  }
  
  void pressed(float x, float y){
    if (sqrt(sq(this.x - x) + sq(this.y - y)) < r/1.5)
      down = true;
  }
  
  void released(){
    down = false;
  }
  
  void myPrint(){
    stroke(borderColor.r, borderColor.g, borderColor.b);
    strokeWeight(borderWidth);
    if (down)
      fill(clickedColor.r, clickedColor.g, clickedColor.b);
    else
      fill(unclickedColor.r, unclickedColor.g, unclickedColor.b);
      
    ellipse(x, y, r, r);
  }
}
