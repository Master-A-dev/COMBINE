abstract class Vehicle {

  PVector position; 
  PVector acc; 
  PVector vel; 
  PVector desired; 
  float maxspeed; 
  float oldspeed; 
  float maxforce; 
  float size; 
  float range;
  int timer;
  int counter;
  



void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    position.add(vel);
    acc.mult(0);
  }


  void seek(Vehicle _target) {}
  void move(Vehicle _target){}
  void flee(Vehicle _target) {}
  void display() {}
  void wander(){}
  
  void applyForce(PVector force) {
    acc.add(force);
  }
 
  

   
  
  
}
