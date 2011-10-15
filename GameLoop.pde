int nextSpawnTime;


void startNewGame () {
  gameStartTime = millis();
  
  startPlayingAudio();
  
  // initialisation
  a1 = new Argonaut();
  enemies = new ArrayList();
  for (int i = 0; i < 10; i++) {
    PVector pv = new PVector (random(0,width), random(0, height));
    while (radiusCollision (a1.pos, a1.mRadius, pv, 10)) {
      pv = new PVector (random(0,width), random(0, height));
    }
    Enemy e = new Enemy(pv);
    enemies.add(e);
  }
  explosions = new ArrayList();
  lasers = new ArrayList();
  newEnemies = new ArrayList();
  lastLoopTime = millis();
  nextSpawnTime = millis() + (int) random(1000,2000);
  
  delay(500);
}

void keyPressed () {
  if (gameState != 0) {
    if (key == 'w') {
      a1.moveUpPressed = true;
    }
    if (key == 's') {
      a1.moveDownPressed = true;
    }
    if (key == 'a') {
      a1.moveLeftPressed = true;
    }
    if (key == 'd') {
      a1.moveRightPressed = true;
    }
    if (key == 'i') {
      a1.mirrorUpPressed = true;
    }
    if (key == 'k') {
      a1.mirrorDownPressed = true;
    }
    if (key == 'j') {
      a1.mirrorLeftPressed = true;
    }
    if (key == 'l') {
      a1.mirrorRightPressed = true;
    }
  }
}

void keyReleased () {
  
  if (key == 'w') {
      a1.moveUpPressed = false;
    }
    if (key == 's') {
      a1.moveDownPressed = false;
    }
    if (key == 'a') {
      a1.moveLeftPressed = false;
    }
    if (key == 'd') {
      a1.moveRightPressed = false;
    }
    if (key == 'i') {
      a1.mirrorUpPressed = false;
    }
    if (key == 'k') {
      a1.mirrorDownPressed = false;
    }
    if (key == 'j') {
      a1.mirrorLeftPressed = false;
    }
    if (key == 'l') {
      a1.mirrorRightPressed = false;
    }
}


void mainGameLoop () {
  
  // set background
  background (0);
  imageMode(CENTER);
  image(backgroundImage, width/2, height/2, 1280,800);
  
  // receive player input
  
  
  // updates
  a1.updatePosition();
  if (nextSpawnTime < millis()) {
     PVector pv = new PVector (random(0,width), random(0, height));
     while (radiusCollision (a1.pos, a1.mRadius, pv, 10)) {
       pv = new PVector (random(0,width), random(0, height));
     }
     Enemy e = new Enemy(pv);
     newEnemies.add(e);
     medusaSpawn.trigger();
     nextSpawnTime = millis() + (int) random(5000,10000); 
  }
  for (int i = 0; i < enemies.size(); i++) {
    Enemy nextEnemy = (Enemy) enemies.get(i);
    nextEnemy.updatePosition();
  }
  
  for (int i = 0; i < newEnemies.size(); i++) {
    Enemy nextEnemy = (Enemy) newEnemies.get(i);
    enemies.add(nextEnemy);
    medusaSpawn.trigger();
  }
  newEnemies.clear();
  
  for (int i = 0; i < explosions.size(); i++) {
    Explosion nextEx = (Explosion) explosions.get(i);
    nextEx.updatePosition();
  }
  
  
  for (int i = 0; i < lasers.size(); i++) {
    Laser nextLaser = (Laser) lasers.get(i);
    nextLaser.updatePosition();
  }
  // draws
  strokeWeight(5);
  for (int i = 0; i < lasers.size(); i++) {
    Laser nextLaser = (Laser) lasers.get(i);
    nextLaser.drawLaser();
  }
  
  for (int i = 0; i < explosions.size(); i++) {
    Explosion nextEx = (Explosion) explosions.get(i);
    nextEx.drawExplosion();
  }
  for (int i = 0; i < enemies.size(); i++) {
    Enemy nextEnemy = (Enemy) enemies.get(i);
    nextEnemy.drawEnemy();
  }
  
  
  a1.drawArgonaut();
  
  image(powerImage, 60,20, 56,17);
  image(scoreImage, width - 100, 20, 53,19);
  
  textSize(20);
  text(a1.power, 100, 20); 
  text(a1.score, width - 20, 20);
  
}
