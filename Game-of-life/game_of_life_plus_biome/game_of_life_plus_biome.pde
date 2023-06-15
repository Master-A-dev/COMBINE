Cell Cell;

void setup() {
  //size(640,480);
  fullScreen();
  Cell = new Cell();
}


void draw() { //tegner baggrund og kalder celldraw og generate der er det som genererer og tegner cellerne
  background(255);
  Cell.cellDraw();
  Cell.generate();
}
