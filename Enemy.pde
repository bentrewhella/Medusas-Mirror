PImage spriteN;
  PImage spriteNE;
  PImage spriteE;
  PImage spriteSE;
  PImage spriteS;
  PImage spriteSW;
  PImage spriteW;
  PImage spriteNW;

class Enemy {
  PVector pos;
  PVector bearing;
  int mRadius;
  int speed;
  int timeNextShot;
  int timeLastShot;
  int medusaDirection;
  
  
  
   Enemy (PVector tPos) {
    pos = tPos;
    mRadius = 60;
    speed = 10;
    bearing = new PVector (random (-1, 1), random (-1, 1));
    timeNextShot = (int) random(2000,10000);
    timeLastShot = millis();
    
    medusaDirection = 0;
  }
  
  void die () {
    Explosion ex = new Explosion (pos, 60, 400);
    explosions.add(ex);
    enemies.remove(this);
    medusaDeath1.trigger();
  }
  
  void shootGun() {
    if (millis() > timeLastShot + timeNextShot) {
      PVector targetVector = new PVector(a1.pos.x - pos.x, a1.pos.y - pos.y);
      targetVector.mult(0.05);
      PVector bulletPos = new PVector(pos.x, pos.y);
      Laser newLaser = new Laser(bulletPos, targetVector);
      lasers.add(newLaser);
      timeLastShot = millis();
      timeNextShot = (int) random(4000,7000);
      medusaShoot.trigger();
    }
  }
  
  void updatePosition () {
    float xDistance = a1.pos.x - pos.x;
    float yDistance = a1.pos.y - pos.y;
    float ratio = 0.002;
    
    //PVector newBearing = new PVector (bearing.x+ratio*xDistance, bearing.y+ratio*yDistance);
    PVector targetBearing = new PVector (ratio*xDistance, ratio*yDistance);
    //newBearing.add(bearing);
    //bearing = newBearing;
    
    pos.add(bearing);
    pos.add(bearing);
    pos.add(targetBearing);
    
    
    if (bounceVertical(pos, mRadius)) {
      bearing.y *=-1;
    }
    if (bounceHorizontal(pos, mRadius)) {
      bearing.x *=-1;
    }
    
    for (int i = 0; i < enemies.size(); i++ ) {
      Enemy nextEnemy = (Enemy) enemies.get(i);
      if (nextEnemy != this) {
        if (radiusCollision (pos, mRadius, nextEnemy.pos, nextEnemy.mRadius)) {
          bearing = new PVector (random (-1, 1), random (-1, 1));
          pos.add(bearing);
          
        }
      }
    }
    
    
    // shoot bullets
    shootGun();
    
    // collision detection
    
    // first collision detect the shield and reverse 
    if (radiusCollision (pos, mRadius, a1.shieldPos, a1.shieldRadius)) {
      PVector newBearing = new PVector(mouseX-pos.x, mouseY-pos.y);
      newBearing.normalize();
      newBearing.mult(3);
      bearing = newBearing;
    }
  
    else if (radiusCollision (pos, mRadius, a1.pos, a1.mRadius)) {
      // hit
      a1.collision();
      die();
    }
    
    boolean medusaUp = false;
    boolean medusaDown = false;
    boolean medusaLeft = false;
    boolean medusaRight = false;
    
    if (a1.pos.x < pos.x -50) {
      medusaLeft = true;
    }
    else if (a1.pos.x > pos.x + 50) {
      medusaRight = true;
    }
    
    if (a1.pos.y < pos.y - 50) {
      medusaUp = true;
    }
    if (a1.pos.y > pos.y + 50) {
      medusaDown = true;
    }
    
    if (medusaUp && medusaLeft) {
        medusaDirection = 5;
      }
      else if (medusaUp && medusaRight) {
        medusaDirection = 7;
        
      }
      else if (medusaDown && medusaLeft) {
        medusaDirection = 3;
        
      }
      else if (medusaDown && medusaRight) {
        medusaDirection = 1;
        
      }
      else if (medusaUp) {
        medusaDirection = 6;
        
      }
      else if (medusaDown) {
        medusaDirection = 2;
        
      }
      else if (medusaLeft) {
        medusaDirection = 4;
        
      }
      else if (medusaRight) {
        medusaDirection = 0;
        
      }
  }
  
  void drawEnemy () {
   /* ellipseMode (CENTER);
    fill(125,0, 125);
    stroke (255, 10, 255);
    ellipse (pos.x, pos.y, mRadius, mRadius);*/
    
    imageMode(CENTER);
    switch (medusaDirection) {
      case 0:
       image(spriteE, pos.x, pos.y, mRadius*2.0, mRadius*2.0);
       break;
      case 1:
       image(spriteSE, pos.x, pos.y, mRadius*2.0, mRadius*2.0);
       break;
     case 2:
       image(spriteS, pos.x, pos.y, mRadius*2.0, mRadius*2.0);
       break;
     case 3:
       image(spriteSW, pos.x, pos.y, mRadius*2.0, mRadius*2.0);
       break;
     case 4:
       image(spriteW, pos.x, pos.y, mRadius*2.0, mRadius*2.0);
       break;
     case 5:
       image(spriteNW, pos.x, pos.y, mRadius*2.0, mRadius*2.0);
       break;
     case 6:
       image(spriteN, pos.x, pos.y, mRadius*2.0, mRadius*2.0);
       break;  
     case 7:
       image(spriteNE, pos.x, pos.y, mRadius*2.0, mRadius*2.0);
       break;
    }
  }
  
}
