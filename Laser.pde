class Laser {
  PVector pos;
  PVector bearing;
  int startTime;
  boolean reflected;
  
  Laser (PVector tPos, PVector tBearing) {
    pos = tPos;
    bearing = tBearing;
    bearing.mult(0.3);
    reflected = false;
    startTime = millis();
  }
  
  void die () {
    Explosion ex = new Explosion (pos, 60, 400);
    explosions.add(ex);
    lasers.remove(this);
  }
  
  void updatePosition () {
    if (reflected && millis() - startTime > 3000) {
      lasers.remove(this);
      return;
    }
    if (!reflected && millis() - startTime > 1500) {
      lasers.remove(this);
      return;
    }
    pos.add(bearing);
    
    if (bounceVertical(pos, 0)) {
      bearing.y *= -1;
    }
    if (bounceHorizontal(pos, 0)) {
      bearing.x *= -1;
    }
    
    // run through all game objects for collision
    // shield
    if (radiusCollision(pos, 1, a1.shieldPos, a1.shieldRadius)) {
      jasonReflect.trigger();
      reflected = true;
      startTime = millis();
      
      PVector newBearing = new PVector(mouseX-pos.x, mouseY-pos.y);
      newBearing.normalize();
      newBearing.mult(6);
      
      bearing = newBearing;
      //bearing.x *= -1;
      //bearing.y *= -1;
    }
    
    //argonaut
    else if (radiusCollision(pos, 1, a1.pos, a1.mRadius)) {
      a1.collision();
      die();
    }
    
    for (int i = 0; i < enemies.size(); i++) {
      Enemy nextEnemy = (Enemy) enemies.get(i);
      if (reflected && radiusCollision(pos, 1, nextEnemy.pos, nextEnemy.mRadius)) {
        die();
        nextEnemy.die();
        a1.score += 100;
      }
    }

  }
  
  void drawLaser () {
    if (!reflected) {
      stroke(255);
    }
    else {
      stroke(125,255,125);
    }
    strokeWeight(5);
    point(pos.x, pos.y);
    /*pushMatrix();
    rotate(bearing.heading2D());
    stroke(255);
    line(0,0,10,0);
    popMatrix();*/
  }
}
