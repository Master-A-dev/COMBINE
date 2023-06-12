class prey extends Vehicle {


  prey(PVector _p, float _maxspeed, float _maxforce, float _range) {
    position = _p;
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    size = 5;
    maxforce = _maxforce;
    maxspeed = _maxspeed;
    oldspeed = _maxspeed;
    range = _range;
    desired = new PVector(width/2, height/2);
    timer = millis();
    Btimer = millis();
    counter = 500;
    Bcounter = 50;
  }

  void onCell(Cell _target) {
    int x = int(position.x/_target.w);
    int y = int(position.y/_target.w);

    if (x > 0 && x < _target.columns && y > 0 && y < _target.rows) {
    }
    if (_target.board[x][y] < 3) {
      maxspeed *= 1;
    }
    if (_target.board[x][y] >= 3) {
      maxspeed = 1.5;
    }
    if (_target.board[x][y] == 1) {
      hunger += 2;
      _target.board[x][y] = 0;
    }
  }



  void move(Vehicle _target) {
    if ((position.x > width - 50) || (position.x < 50)) {  //border on x
      vel.x = vel.x * -1;
      desired.x *= -1;
      Btimer = millis();
      print("border x");
    } else if ((position.y > height - 50) || (position.y < 50)) {  //border on y
      vel.y = vel.y * -1;
      desired.y *= -1;
      Btimer = millis();
      print("border y");
    } else if (dist(position.x, position.y, _target.position.x, _target.position.y) < range) { //Starts the fleeing behavior
      flee(_target);
      maxspeed *= 1.04; //Makes the pray move faster when it flees
    } else if (millis() - timer > counter) {   //starts the animals wandering behavior 
      wander();
      timer = millis();
      if (hunger > 0) {
        hunger -= 1;
      }
    }


    if (dist(position.x, position.y, _target.position.x, _target.position.y) > _target.range*2) { // makes so the prey stop running fast when the hunter is not there
      maxspeed = oldspeed;
    }

    PVector steer = PVector.sub(desired, vel);  //makes the animal move
    steer.limit(maxforce);
    applyForce(steer);
  }


  void flee(Vehicle _target) {
    desired = PVector.sub(_target.position, position).mult(-1);
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

  boolean isEaten(Vehicle _target) { //determins if ther herbivore is eaten or not
    if (dist(_target.position.x, _target.position.y, position.x, position.y) <= 15) {
      return true;
    } else {
      return false;
    }
  }
  boolean fullHunger() {
    if (hunger >= 100) {
      hunger -= 50;
      return true;
    } else {
      return false;
    }
  }


  void display() {
    //Vehicle is a triangle pointing in the direction of velocity; since it is drawn pointing up, we rotate it an additional 90 degrees.
    float theta = vel.heading() + PI/2;
    fill(#FFFFFF);
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
