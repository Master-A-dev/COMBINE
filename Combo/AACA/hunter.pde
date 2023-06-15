class hunter extends Vehicle {

  hunter(PVector _p, float _maxspeed, float _maxforce, float _range) {
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
    if (_target.board[x][y] < 1) {
      maxspeed *= 1;
    }
    if (_target.board[x][y] > 3) {
      maxspeed = 2;
    }
  }

  void seek(Vehicle _target) {
    desired = PVector.sub(_target.position, position);
    desired.normalize();
    desired.mult(maxspeed);
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
    } else if (dist(position.x, position.y, _target.position.x, _target.position.y) < range) {  //hunting behavior if target is inside a given range
      seek(_target);
      maxspeed *= 1.02;
    } else if (millis() - timer > counter) {    //starts the animals wandering behavior
      maxspeed = oldspeed;
      wander();
      timer = millis();
      if (hunger > 0) {
        hunger -= 0.5;
      }
    }
    if (dist(_target.position.x, _target.position.y, position.x, position.y) <= 15) {
      hunger += 50;
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);
    applyForce(steer);
  }



  void wander() {    //makes the target move to a new point via polar vectors
    float r = 20.5;
    float x = r*cos(random(360));
    float y = r*sin(random(360));

    desired.sub(new PVector(x, y));
    desired.normalize();
    desired.mult(maxspeed);
  }


  boolean fullHunger() {
    if (hunger >= 100) {
      print ("full hunger");
      hunger -= 50;
      return true;
    } else {
      return false;
    }
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
    vertex(0, -size*5);
    vertex(-size*3, size*5);
    vertex(size*3, size*5);
    endShape(CLOSE);
    popMatrix();
  }
}
