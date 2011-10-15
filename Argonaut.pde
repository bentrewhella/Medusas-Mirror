class Argonaut {
  
  PVector pos;
  int mRadius;
  int speed;
  float verticalForce;
  float horizontalForce;
  int power;
  
  int shieldPosition;
  PVector shieldPos;
  int shieldRadius;
  int timeBounced;
  int score;
  boolean moveUpPressed, moveDownPressed, moveLeftPressed, moveRightPressed; // player 1 actions
  boolean mirrorUpPressed, mirrorDownPressed, mirrorLeftPressed, mirrorRightPressed; // player 2 actions
  
  PImage spriteN;
  PImage spriteNE;
  PImage spriteE;
  PImage spriteSE;
  PImage spriteS;
  PImage spriteSW;
  PImage spriteW;
  PImage spriteNW;
  
  
  
  Argonaut () {
    moveUpPressed = moveDownPressed = moveLeftPressed = moveRightPressed = false;
    mirrorUpPressed = mirrorDownPressed = mirrorLeftPressed = mirrorRightPressed = false;
    
    pos = new PVector (width/2, height/2);
    mRadius = 48;
    speed = 20;
   
    verticalForce = 0;
    horizontalForce = 0; 
    
    power = 10;
    
    shieldPosition = 0;
    shieldRadius = mRadius*3/2;
    shieldPos = new PVector (pos.x+shieldRadius/2, pos.y);
    
    spriteN = loadImage ("Jason_N.tga");
    spriteNE = loadImage ("Jason_NE.tga");
    spriteE = loadImage ("Jason_E.tga");
    spriteSE = loadImage ("Jason_SE.tga");
    spriteS = loadImage ("Jason_S.tga");
    spriteSW = loadImage ("Jason_SW.tga");
    spriteW = loadImage ("Jason_W.tga");
    spriteNW = loadImage ("Jason_NW.tga");
    timeBounced = millis();
    score = 0;
    
  }
  
  void collision () {
    power--;
    jasonDeath.trigger();
    if (power == 0) {
      endMusic();
      jasonDeath.trigger();
      gameState = 2;
    }
  }
  
  void playFootsteps() {
    
  }
  
  
  void updatePosition () {
    // up down
    float moveSpeed = (frameTime*100) / speed;
    
    if (moveUpPressed && !moveDownPressed) {
      //verticalForce -=  moveSpeed;
      if (verticalForce > -10) {
        verticalForce -= 0.5;
        playFootsteps();
      }
    }
    if (!moveUpPressed && moveDownPressed) {
      //verticalForce +=  moveSpeed;
      if (verticalForce < 10) {
        verticalForce += 0.5;
        playFootsteps();
      }
      
    }
    if (moveDownPressed && moveUpPressed || !moveDownPressed && !moveUpPressed) {
      verticalForce *= 0.9;
    }
    if (bounceVertical(pos, mRadius) && millis() - timeBounced > 10) {
      verticalForce *= -1;
      timeBounced = millis();
    }
    pos.y += verticalForce;
    shieldPos.y += verticalForce;
    
    // left right
    if (moveLeftPressed && !moveRightPressed) {
      //horizontalForce -=  moveSpeed;
       if (horizontalForce > -10) {
        horizontalForce -= 0.5;
        playFootsteps();
       }
    }
    if (!moveLeftPressed && moveRightPressed) {
      //horizontalForce +=  moveSpeed;
      if (horizontalForce < 10) {
        horizontalForce += 0.5;
        playFootsteps();
       }
    }
    if (moveLeftPressed && moveRightPressed || !moveLeftPressed && !moveRightPressed) {
      horizontalForce *= 0.9;
    }
    if (bounceHorizontal(pos, mRadius) && millis() - timeBounced > 10) {
      horizontalForce *= -1;
      timeBounced = millis();
    }
    pos.x += horizontalForce;
    shieldPos.x += horizontalForce;
    
    // shield position
    boolean shieldUp = false;
    boolean shieldDown = false;
    boolean shieldLeft = false;
    boolean shieldRight = false;
    
    if (mouseX < pos.x -50) {
      shieldLeft = true;
    }
    else if (mouseX > pos.x + 50) {
      shieldRight = true;
    }
    
    if (mouseY < pos.y - 50) {
      shieldUp = true;
    }
    if (mouseY > pos.y + 50) {
      shieldDown = true;
    }
    
    
    /*
    if (mirrorUpPressed || mirrorDownPressed || mirrorLeftPressed || mirrorRightPressed) {     
      if (mirrorRightPressed && !mirrorLeftPressed) {
        shieldRight = true;
      }
      if (mirrorLeftPressed && !mirrorRightPressed) {
        shieldLeft = true;
      }
      if (mirrorUpPressed && ! mirrorDownPressed) {
        shieldUp = true;
      }
      if (mirrorDownPressed && !mirrorUpPressed) {
        shieldDown = true;
      } 
      */
      if (shieldUp && shieldLeft) {
        shieldPosition = 5;
        shieldPos = new PVector (pos.x-shieldRadius/2, pos.y-shieldRadius/2);
      }
      else if (shieldUp && shieldRight) {
        shieldPosition = 7;
        shieldPos = new PVector (pos.x+shieldRadius/2, pos.y-shieldRadius/2);
      }
      else if (shieldDown && shieldLeft) {
        shieldPosition = 3;
        shieldPos = new PVector (pos.x-shieldRadius/2, pos.y+shieldRadius*.033);
      }
      else if (shieldDown && shieldRight) {
        shieldPosition = 1;
        shieldPos = new PVector (pos.x+shieldRadius/2, pos.y+shieldRadius*0.33);
      }
      else if (shieldUp) {
        shieldPosition = 6;
        shieldPos = new PVector (pos.x, pos.y-shieldRadius*0.66);
      }
      else if (shieldDown) {
        shieldPosition = 2;
        shieldPos = new PVector (pos.x, pos.y+shieldRadius*0.33);
      }
      else if (shieldLeft) {
        shieldPosition = 4;
        shieldPos = new PVector (pos.x-shieldRadius*0.66, pos.y);
      }
      else if (shieldRight) {
        shieldPosition = 0;
        shieldPos = new PVector (pos.x+shieldRadius*0.66, pos.y);
      }
    
    
  }
 
  
  void drawShield () {
    fill (0);
    stroke (255);
    switch (shieldPosition) {
      case 0:
       arc(pos.x, pos.y, mRadius*1.5, mRadius*1.5, 0-PI/4, PI/4);
       break;
      case 1:
       arc(pos.x, pos.y, mRadius*1.5, mRadius*1.5, 0, PI/2);
       break;
     case 2:
       arc(pos.x, pos.y, mRadius*1.5, mRadius*1.5, PI/4, (PI/4)*3);
       break;
     case 3:
       arc(pos.x, pos.y, mRadius*1.5, mRadius*1.5, PI/2, (PI/2)*2);
       break;
     case 4:
       arc(pos.x, pos.y, mRadius*1.5, mRadius*1.5, (PI/4)*3, (PI/4)*5);
       break;
     case 5:
       arc(pos.x, pos.y, mRadius*1.5, mRadius*1.5, PI, (PI/2)*3);
       break;
     case 6:
       arc(pos.x, pos.y, mRadius*1.5, mRadius*1.5, (PI/4)*5, (PI/4)*7);
       break;  
     case 7:
       arc(pos.x, pos.y, mRadius*1.5, mRadius*1.5, (PI/2)*3, 2*PI);
       break;
    }
    
  }
  
  void drawArgonaut () {
    ellipseMode (CENTER);
    //drawShield();
   
    
    //fill(125);
    //stroke (255);
    //ellipse (pos.x, pos.y, mRadius, mRadius);
    imageMode(CENTER);
    switch (shieldPosition) {
      case 0:
       image(spriteE, pos.x, pos.y, mRadius*2.5, mRadius*2.5);
       break;
      case 1:
       image(spriteSE, pos.x, pos.y, mRadius*2.5, mRadius*2.5);
       break;
     case 2:
       image(spriteS, pos.x, pos.y, mRadius*2.5, mRadius*2.5);
       break;
     case 3:
       image(spriteSW, pos.x, pos.y, mRadius*2.5, mRadius*2.5);
       break;
     case 4:
       image(spriteW, pos.x, pos.y, mRadius*2.5, mRadius*2.5);
       break;
     case 5:
       image(spriteNW, pos.x, pos.y, mRadius*2.5, mRadius*2.5);
       break;
     case 6:
       image(spriteN, pos.x, pos.y, mRadius*2.5, mRadius*2.5);
       break;  
     case 7:
       image(spriteNE, pos.x, pos.y, mRadius*2.5, mRadius*2.5);
       break;
    }
    
    /*
    fill(50);
    stroke (100);
    ellipse (pos.x, pos.y, mRadius, mRadius);
    
    fill(100);
    stroke (100);
    ellipse (shieldPos.x, shieldPos.y, shieldRadius, shieldRadius);
    */
  }
}


