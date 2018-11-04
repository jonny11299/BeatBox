class Slider{
  float x1;
  float y1;
  float x2;
  float y2;
  boolean horizontal;
  
  float knobSize = 15;
  float unfilledWeight = 2;
  float filledWeight = 8;
  
  public float val = 0.5;
  
  boolean grabbed = false;
  
  Color unfilledColor = new Color(0, 0, 0);
  Color filledColor = new Color(0, 128, 255);
  Color knobColor = new Color(255, 255, 255);
  
  Slider(float x1, float y1, float myLength, boolean isHorizontal){
    horizontal = isHorizontal;
    if (horizontal){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x1 + myLength;
      this.y2 = y1;
    }else{
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x1;
      this.y2 = y1 - myLength;
    }
  }
  
  Slider(float x1, float y1, float myLength, boolean isHorizontal, float val){
    horizontal = isHorizontal;
    if (horizontal){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x1 + myLength;
      this.y2 = y1;
    }else{
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x1;
      this.y2 = y1 - myLength;
    }
    
    this.val = val;
  }
  
  Slider(float x1, float y1, float myLength, boolean isHorizontal, float val, Color filledColor){
    horizontal = isHorizontal;
    if (horizontal){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x1 + myLength;
      this.y2 = y1;
    }else{
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x1;
      this.y2 = y1 - myLength;
    }
    
    this.val = val;
    this.filledColor = filledColor;
  }
  
  
  void myPrint(){
    if (grabbed){
      if (horizontal){
        val = map(mouseX, x1, x2, 0, 1);
      }else{
        val = map(mouseY, y2, y1, 1, 0);
      }
      if (val > 1) val = 1;
      if (val < 0) val = 0;
    }
    
    stroke(unfilledColor.r, unfilledColor.g, unfilledColor.b);
    strokeWeight(unfilledWeight);
    line(x1, y1, x2, y2);
    
    stroke(filledColor.r, filledColor.g, filledColor.b);
    strokeWeight(filledWeight);
    float x3 = map(val, 0, 1, x1, x2);
    float y3 = map(val, 0, 1, y1, y2);
    line(x1, y1, x3, y3);
    
    stroke(0, 0, 0);
    strokeWeight(1);
    fill(knobColor.r, knobColor.g, knobColor.b);
    ellipse(x3, y3, knobSize, knobSize);
  }
  
  void pressed(float x, float y){
    float x3 = map(val, 0, 1, x1, x2);
    float y3 = map(val, 0, 1, y1, y2);
    
    if (sqrt(sq(x3 - x) + sq(y3 - y)) <= knobSize)
      grabbed = true;
      
  }
  
  void released(){
    grabbed = false;
  }
}
