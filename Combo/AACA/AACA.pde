Cell Cell;
Vehicle prey;
int startPrey = 10;
ArrayList<Vehicle> newPrey = new ArrayList<Vehicle>();
Vehicle hunter;
ArrayList<Float> closes = new ArrayList<Float>();
int targetObj;
float oldD = width * height;
float newD;
boolean wasEaten = false; //tells if a prey was eaten
int whoEaten; //tels which one was eaten
int time = 0;  //Makes so the preloader kan reset
int timer;     //A timer that works with counter
int counter = 50;  //How often the game goes through a new generation
int preloadtime = 20000;  //How long it goes through a new generation every frame (How long the "preloader" is active)


void setup(){
frameRate(60);
fullScreen();
//size(640, 480);




  for (int i = 0; i < startPrey; i++) {
    newPrey.add(new prey(new PVector(width/4, height/4), 6, 0.6, 100));
    closes.add(width*height*0.9);
  }
hunter = new hunter(new PVector (width/2, height/2), 6, 3, 300);
Cell = new Cell();
}




void draw(){
background(0);

Cell.cellDraw();
  if (millis() < preloadtime) {  //Goes through a new generation every frame for a certain amount of time
    Cell.generate();
  } else if (millis()-timer > counter) { // a timer
    Cell.generate();
    timer = millis();
  } 


for (int i = newPrey.size()-1; i >= 0; i--) { //runs the prey
    Vehicle nextPrey = newPrey.get(i);
    nextPrey.move(hunter);
    nextPrey.update();
    nextPrey.display();
    nextPrey.onCell(Cell);
    if (nextPrey.isEaten(hunter)) { //delets the prey if it's eaten
      wasEaten = true;
      whoEaten = i;
      print(" "+i+" was eaten");
    }
    if (nextPrey.fullHunger()){
      newPrey.add(new prey(new PVector(random(300, 1600), random(200, 900)), 6, 0.6, 100));
      closes.add(width*height*0.9);
      print("sex");
    }


    closes.set(i, dist(hunter.position.x, hunter.position.y, nextPrey.position.x, nextPrey.position.y)); // chooses the target the hunter goes after
    newD = closes.get(i);
    if (oldD > newD) { 
      oldD = newD;
      targetObj = i;
    }
  }

 hunter.move(newPrey.get(targetObj));
  oldD = width*height; // resets oldD
  hunter.update();
  hunter.display();
  hunter.onCell(Cell);
  if (wasEaten == true) { // eats the prey. 
    wasEaten = false;
    int preySize = newPrey.size()-1;
    print(preySize);
    newPrey.set(whoEaten, newPrey.get(preySize)); 
    newPrey.remove(preySize);
    closes.remove(preySize); 
  }

}
