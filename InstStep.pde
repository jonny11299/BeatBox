class InstStep{
  BeatBox APPLET;
  ArrayList<NoteDot> notes = new ArrayList<NoteDot>();
  ArrayList<NoteSquare> squareNotes = new ArrayList<NoteSquare>();
  String type = "dot"; //dot or square
  
  InstStep(BeatBox appletIn){
    APPLET = appletIn;
  }
  
  void makeNote(NoteDot dot){
    notes.add(dot);
    dot.play();
  }
  void makeNote(NoteSquare square){
    squareNotes.add(square);
    square.play();
  }
  
  void myPrint(){
    for (int i = 0 ; i < notes.size() ; ++i){
      if (!notes.get(i).done()){
        notes.get(i).myPrint();
      }
    }
    for (int i = 0 ; i < squareNotes.size() ; ++i){
      if (!squareNotes.get(i).done()){
        squareNotes.get(i).myPrint();
      }
    }
  }
  
  void play(){
    for(int i = 0 ; i < notes.size() ; ++i){
      notes.get(i).play();
    }
    for(int i = 0 ; i < squareNotes.size() ; ++i){
      squareNotes.get(i).play();
    }
  }
  
  void myClear(){
    while (notes.size() != 0){
      notes.remove(0);
    }
    while (squareNotes.size() != 0){
      squareNotes.remove(0);
    }
  }
  
  void removeLast(){
    if (notes.size() != 0)
      notes.remove(notes.size() - 1);
    if (squareNotes.size() != 0)
      squareNotes.remove(squareNotes.size() - 1);
  }
  
  void setMasterVolume(float volIn){
    for(int i = 0 ; i < notes.size() ; ++i){
      notes.get(i).setMasterVolume(volIn);
    }
    for(int i = 0 ; i < squareNotes.size() ; ++i){
      squareNotes.get(i).setMasterVolume(volIn);
    }
  }
  
  void changeEnv(float a, float s, float lvl, float r){
    for (int i = 0 ; i < notes.size() ; ++i){
      notes.get(i).env.a = a;
      notes.get(i).env.s = s;
      notes.get(i).env.lvl = lvl;
      notes.get(i).env.r = r;
    }
    for (int i = 0 ; i < squareNotes.size() ; ++i){
      squareNotes.get(i).env.a = a;
      squareNotes.get(i).env.s = s;
      squareNotes.get(i).env.lvl = lvl;
      squareNotes.get(i).env.r = r;
    }
  }
}
