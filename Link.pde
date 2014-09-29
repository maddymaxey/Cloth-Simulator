
class Link {
  float restingDistance;
  float stiffness;
  float tearSensitivity;
  
  PointMass p1;
  PointMass p2;

  boolean drawThis = true;
  
  Link(PointMass which1, PointMass which2, float restingDist, float stiff, float tearSensitivity, boolean drawMe) {
    p1 = which1;  
    p2 = which2; 
    
    restingDistance = restingDist;
    stiffness = stiff;
    drawThis = drawMe;

  }
 
  void solve() {
  
    float diffX = p1.x - p2.x;
    float diffY = p1.y - p2.y;
    float d = sqrt(diffX * diffX + diffY * diffY);
   
    float difference = (restingDistance - d) / d;

    float im1 = 1 / p1.mass;
    float im2 = 1 / p2.mass;
    float scalarP1 = (im1 / (im1 + im2)) * stiffness;
    float scalarP2 = stiffness - scalarP1;

    p1.x += diffX * scalarP1 * difference;
    p1.y += diffY * scalarP1 * difference;
    
    p2.x -= diffX * scalarP2 * difference;
    p2.y -= diffY * scalarP2 * difference;
  }

  void draw() {
    if (drawThis)
      line(p1.x, p1.y, p2.x, p2.y);
  }
}
