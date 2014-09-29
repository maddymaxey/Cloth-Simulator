
class Physics {
  long previousTime;
  long currentTime;
  
  int fixedDeltaTime;
  float fixedDeltaTimeSeconds;
  
  int leftOverDeltaTime;
  
  int constraintAccuracy;
  
  Physics() {
    fixedDeltaTime = 16;
    fixedDeltaTimeSeconds = (float)fixedDeltaTime / 1000.0;
    leftOverDeltaTime = 0;
    constraintAccuracy = 3;
  }
  

  void update() {

    currentTime = millis();
    long deltaTimeMS = currentTime - previousTime;
    
    previousTime = currentTime; 

    int timeStepAmt = (int)((float)(deltaTimeMS + leftOverDeltaTime) / (float)fixedDeltaTime);
    

    timeStepAmt = min(timeStepAmt, 5);

    leftOverDeltaTime = (int)deltaTimeMS - (timeStepAmt * fixedDeltaTime);

    

    for (int iteration = 1; iteration <= timeStepAmt; iteration++) {

      for (int x = 0; x < constraintAccuracy; x++) {
        for (int i = 0; i < pointmasses.size(); i++) {
          PointMass pointmass = (PointMass) pointmasses.get(i);
          pointmass.solveConstraints();
        }
        
      }
      

      for (int i = 0; i < pointmasses.size(); i++) {
        PointMass pointmass = (PointMass) pointmasses.get(i);
        pointmass.updateInteractions();
        pointmass.updatePhysics(fixedDeltaTimeSeconds);
      }
    }
  }
  
  
}
