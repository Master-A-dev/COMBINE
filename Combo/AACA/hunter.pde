class hunter extends Vehicle {

  hunter(PVector _p, float _maxspeed, float _maxforce, float _range) {
    position = _p;
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    size = 3.0;
    maxforce = _maxforce;
    maxspeed = _maxspeed;
    oldspeed = _maxspeed;
    range = _range;
    desired = new PVector(width/2, height/2);
    timer = millis();
    counter = 500;
  }



  void move(Vehicle _target) {

    if ((position.x > width) || (position.x < 0)) {  //border on x
      vel.x = vel.x * -1;
      desired.x *= -1;
    } else if ((position.y > height) || (position.y < 0)) {  //border on y
      vel.y = vel.y * -1;
      desired.y *= -1;
    } else if (dist(position.x, position.y, _target.position.x, _target.position.y) < range) { //Starts the fleeing behavior
      seek(_target);
      maxspeed *= 1.01; //Makes the hunter move faster when it hunts
      print("hunt");
    } else if (millis() - timer > counter) {   //starts the animals wandering behavior 
      maxspeed = oldspeed;
      wander();
      timer = millis();
      print("Wander");
    }




    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void seek(Vehicle _target) {
    desired = PVector.sub(_target.position, position);
    desired.normalize();
    desired.mult(maxspeed);
  }

  void wander() {    //makes the target move to a new point via polar vectors
    float r = 20.5;
    float x = r*cos(random(360));
    float y = r*sin(random(360));

    desired.sub(new PVector(x, y));
    desired.normalize();
    desired.mult(maxspeed);
  }



  void display() {
    //image(pic,position.x,position.y);
    float theta = vel.heading() + PI/2;
    fill(255, 0, 0);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -size*4);
    vertex(-size*2, size*4);
    vertex(size*2, size*4);
    endShape(CLOSE);
    popMatrix();
  }
}
