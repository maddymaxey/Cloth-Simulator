
class PointMass {
  float lastX, lastY; 
  float x,y;
  float accX, accY; 
  float mass = 1;
  float damping = 20;  
  ArrayList links = new ArrayList(); 
  boolean pinned = false;
  float pinX, pinY;
  PointMass(float xPos, float yPos) {
    x = xPos;
    y = yPos;
    
    lastX = x;
    lastY = y;
    
    accX = 0;
    accY = 0;
  }
  

  void updatePhysics(float timeStep) { 
    this.applyForce(0, mass * gravity);
    
    float velX = x - lastX;
    float velY = y - lastY;

    velX *= 0.99;
    velY *= 0.99;

    float timeStepSq = timeStep * timeStep;


    float nextX = x + velX + 0.5 * accX * timeStepSq;
    float nextY = y + velY + 0.5 * accY * timeStepSq;

    lastX = x;
    lastY = y;
    
    x = nextX;
    y = nextY;
    
    accX = 0;
    accY = 0;
  }
 
  void updateInteractions() {
    if (x == 52.0 && y == 200.27635 ){
      for(int time = 0; time <= 100000; time ++)
      println (y);
     float randomX = random(-1000,3000);
      float randomY = random(-3000,-1000);
        lastX = x - (100)* randomX;
        lastY = y - (100)* randomY;
      }
    }

  void draw() {

    stroke(100);
    if (links.size() > 0) {
      for (int i = 0; i < links.size(); i++) {
        Link currentLink = (Link) links.get(i);
        currentLink.draw();
      }
    }
    else
      point(x, y);
  }

  void solveConstraints() {
   
    for (int i = 0; i < links.size(); i++) {
      Link currentLink = (Link) links.get(i);
      currentLink.solve();
    }

    if (y < 1)
      y = 2 * (1) - y;
    if (y > height-1)
      y = 2 * (height - 1) - y;
      
    if (x > width-1)
      x = 2 * (width - 1) - x;
    if (x < 1)
      x = 2 * (1) - x;

  }

  void attachTo(PointMass P, float restingDist, float stiff) {
    attachTo(P, restingDist, stiff, 30, true);
  }
  void attachTo(PointMass P, float restingDist, float stiff, boolean drawLink) {
    attachTo(P, restingDist, stiff, 30, drawLink);
  }
  void attachTo(PointMass P, float restingDist, float stiff, float tearSensitivity) {
    attachTo(P, restingDist, stiff, tearSensitivity, true);
  }
  void attachTo(PointMass P, float restingDist, float stiff, float tearSensitivity, boolean drawLink) {
    Link lnk = new Link(this, P, restingDist, stiff, tearSensitivity, drawLink);
    links.add(lnk);
  }

  void applyForce(float fX, float fY) {
    accX += fX/mass;
    accY += fY/mass;
  }

}


  
