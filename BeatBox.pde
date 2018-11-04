import processing.sound.*;

//Sound engine;
final int SAMPLE_RATE = 44100;

public Helper HELPER = new Helper();
public MouseInput mouseInput = new MouseInput();

Main main;
Inst1 inst1;
Inst2 inst2;
BeatMachine beatMachine;

float defaultPitch = 440; //starts at A = 440
float masterVol = 0.5;

public static int clock = 0;
float tempo = 100;
boolean play = false;
int playedAt = 0; //the clock time when the play button was clicked again
int beat = 0;     //stores the number of quarter notes that have passed
int step = 0; //stores the number of 32nd notes that have passed
boolean trigger = true;


String currentTab;
public Tab mainTab = new Tab(this, "main", 4, 4, 246, 50, HELPER.RED, 4, 3);
public Tab inst1Tab = new Tab(this, "main", 254, 4, 246, 50, HELPER.BLUE, 4, 3);
public Tab inst2Tab = new Tab(this, "main", 504, 4, 246, 50, HELPER.DARK_GREEN, 4, 3);
public Tab beatMachineTab = new Tab(this, "main", 754, 4, 244, 50, HELPER.YELLOW, 4, 3);

//PFont font = createFont("Monospaced.plain", 16);

void setup() {
  //engine = new Sound(this);
  //engine.sampleRate(SAMPLE_RATE); //somehow setting the sample rate always makes me crash, even when it's the same rate that it is already
  
  main = new Main(this);
  inst1 = new Inst1(this);
  inst2 = new Inst2(this);
  beatMachine = new BeatMachine(this);
  
  size(1000, 750);
  background(255);
  
  currentTab = "main";
  
  
  textSize(32);
}      

void draw() {
  clock = millis();
  updateBeat();
  
  main.run();
  inst1.run();
  inst2.run();
  beatMachine.run();
  
  drawScreen();
}


void updateBeat(){
  double beatsPerMs = (double) (1/tempo) * 60 * 1000;
  if (play){
    beat = floor((float) ((clock - playedAt)/beatsPerMs));
    int newStep = floor((float) ((clock - playedAt)/beatsPerMs * 8));
    if (newStep != step)
      trigger = true;
    else
      trigger = false;
    step = newStep;
  }else{
    beat = 0;
    step = 0;
    trigger = false;
  }
  
}

void drawScreen(){
  background(255);
  
  mainTab.myPrint();
  inst1Tab.myPrint();
  inst2Tab.myPrint();
  beatMachineTab.myPrint();
  
  if (main.isVisible())
    main.myPrint();
  if (inst1.isVisible())
    inst1.myPrint();
  if (inst2.isVisible())
    inst2.myPrint();
  if (beatMachine.isVisible())
    beatMachine.myPrint();
    
    
  printMetronome();
}

void printMetronome(){
  stroke(0, 0, 0);
  strokeWeight(4);
  if (step % 8 == 0 && play)
      fill(255, 255, 0);
    else
      fill(128, 128, 0);
    rect(width - 84, 62, 76, 76, 3);
}



void mousePressed() {
  mouseInput.pressed(this, mouseX, mouseY);
}
void mouseReleased(){
  mouseInput.released(this, mouseX, mouseY);
}
void mouseClicked(){
  mouseInput.clicked(this, mouseX, mouseY);
}
void mouseDragged(){
  mouseInput.dragged(this, mouseX, mouseY);
}
