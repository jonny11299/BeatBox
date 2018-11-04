//fill this class with helper methods

class Helper{

  Helper(){}
  
  
  Color randomColor(){
    return new Color(floor(256*random(1)), floor(256*random(1)), floor(256*random(1)));
  }
  public final Color RED = new Color(255, 0, 0);
  public final Color GREEN = new Color(0, 255, 0);
  public final Color BLUE = new Color(0, 0, 255);
  public final Color YELLOW = new Color(255, 255, 0);
  public final Color BLACK = new Color(0, 0, 0);
  public final Color WHITE = new Color(255, 255, 255);
  public final Color DARK_GREEN = new Color(16, 200, 16);
  public final Color GREY = new Color(128, 128, 128);
}
