class Explosion {
  PVector pos;
  
  int startTime;
  float mRadius;
  int explosionLength;
  
  Explosion (PVector tPos, float tRadius, int tExplosionLength) {
    pos = tPos;
    mRadius = tRadius;
    explosionLength = tExplosionLength;
    startTime = millis();
  }
  
  void updatePosition () {
    if ((millis() - startTime) > explosionLength) {
      explosions.remove(this);
    }
  }
  
  void drawExplosion () {
    ellipseMode (CENTER);
    fill(0);
    stroke (255);
    //stroke (255, 10, 255,255*((millis() - startTime)/explosionLength));
    
    int currentTime = millis() - startTime;
    float currentRadius = (mRadius / explosionLength - currentTime)/10;
    
    ellipse (pos.x, pos.y, currentRadius, currentRadius);
  }
}
