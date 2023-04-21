Vehicle prey;
Vehicle hunter;


 PImage pic;

void setup(){
  frameRate(60);
fullScreen();
//size(640, 480);

pic = loadImage("bunga.png");
pic.resize(98,110);
imageMode(CENTER);


hunter = new hunter(new PVector(random(width),random(height)), 6, 0.6, 300);
prey = new prey(new PVector(random(width),random(height)), 6, 0.6, 100);
}




void draw(){
background(0);

hunter.move(prey);
hunter.update();
hunter.display();

prey.move(hunter);
prey.display();
prey.update();
}
