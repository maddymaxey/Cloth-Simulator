
ArrayList<PointMass> pointmasses;

float gravity = 50; 

final int curtainHeight = 100;
final int curtainWidth = 100;
final int yStart = height/2; // where will the curtain start on the y axis?
final float restingDistances = 2;
final float stiffnesses = 1;
final float curtainTearSensitivity = 0;
Physics physics;
void setup() {
  size(600,600);
  physics = new Physics();
  pointmasses = new ArrayList<PointMass>();
  createCurtain();
}

void draw() {
  background(255);
  physics.update();
  updateGraphics();
}

void updateGraphics() {
  for (PointMass p : pointmasses) {
    p.draw();
  }
}

void addPointMass(PointMass p) {
  pointmasses.add(p); 
}



void createCurtain() {
  for (int y = 0; y <= curtainHeight; y++) { 
    for (int x = 0; x <= curtainWidth; x++) { 
      PointMass pointmass = new PointMass(2+ x * restingDistances, y * restingDistances + yStart);

      if (x != 0) 
        pointmass.attachTo((PointMass)(pointmasses.get(pointmasses.size()-1)), restingDistances, stiffnesses);
      if (y != 0)
        pointmass.attachTo((PointMass)(pointmasses.get((y - 1) * (curtainWidth+1) + x)), restingDistances, stiffnesses);

      pointmasses.add(pointmass);
    }
  }
}





