Cell Cell;
Vehicle prey;
Vehicle hunter;


void setup(){
  frameRate(60);
fullScreen();
//size(640, 480);


hunter = new hunter(new PVector(random(width),random(height)), 6, 0.6, 300);
prey = new prey(new PVector(random(width),random(height)), 6, 0.6, 100);
Cell = new Cell();
}




void draw(){
background(0);

Cell.cellDraw();
Cell.generate();

hunter.move(prey);
hunter.update();
hunter.display();

prey.move(hunter);
prey.display();
prey.update();


}
