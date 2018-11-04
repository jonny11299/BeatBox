class DrumBox extends Screen{
  Color filledColor;
  float val; //how much this box is filled from 0 to 1
  boolean grabbed;
  
  SoundFile sample;
  int pos; //the position in the drum track sequence, 0 to 63
  
  DrumBox(BeatBox appletIn, String tab, float x, float y, float w, float h, Color borderColor, Color backgroundColor, Color filledColor, SoundFile sample, int pos){
    super(appletIn, tab, x, y, w, h, borderColor, backgroundColor, 1, 0);
    this.filledColor = filledColor;
    this.sample = sample;
    this.pos = pos;
    grabbed = false;
    val = 0;
  }
  
  void myPrint(){
    if (grabbed){
      val = map(mouseY, y, y + h, 1, 0);
     
      if (val > 1) val = 1;
      if (val < 0) val = 0;
    }
    
    fill(backgroundColor.r, backgroundColor.g, backgroundColor.b);
    stroke(borderColor.r, borderColor.g, borderColor.b);
    strokeWeight(borderWidth);
    rect(x, y, w, h, rounding);
    fill(filledColor.r, filledColor.g, filledColor.b);
    rect(x, y + h, w, -val * h, rounding);
  }
  
  void play(float vol){
    sample.play(1, vol * val);
  }
  
  boolean isEmpty(){
    return val == 0;
  }
  
  void myClear(){
    val = 0;
  }
  
  void pressed(float x, float y){
    if (clickedOn(x, y)){
      grabbed = true;
    }
  }
  void dragged(float x, float y){
    if (clickedOn(x, y)){
      grabbed = true;
    }
  }
  
  void released(float x, float y){
    grabbed = false;
  }
}
