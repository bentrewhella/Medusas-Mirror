

// global variables
int gameState = 0;

// 0 = main menu
// 1 = game loop
// 3 = game over

// timing
int gameStartTime;
int lastLoopTime;
int frameTime;

// global entities
Argonaut a1;
ArrayList enemies;
ArrayList explosions;
ArrayList lasers;
ArrayList newEnemies;
PImage backgroundImage;

PImage gameOverImage, medusaTitleImage, startGameImage;
PImage powerImage, scoreImage;

//setup routine
void setup () {
  frameRate(60);
  size(1280,800);
  
  gameOverImage = loadImage("game_over.png");
  startGameImage = loadImage("start_game.png");
  medusaTitleImage = loadImage("medusa_logo.png");
  backgroundImage = loadImage("floor.tga");
  
  spriteN = loadImage ("Medusa_N.tga");
    spriteNE = loadImage ("Medusa_NE.tga");
    spriteE = loadImage ("Medusa_E.tga");
    spriteSE = loadImage ("Medusa_SE.tga");
    spriteS = loadImage ("Medusa_S.tga");
    spriteSW = loadImage ("Medusa_SW.tga");
    spriteW = loadImage ("Medusa_W.tga");
    spriteNW = loadImage ("Medusa_NW.tga");
    
    powerImage = loadImage("power.png");
    scoreImage = loadImage("score.png");
  
 setUpAudio();
 
}


// main game loop
void draw() {
  
  frameTime = millis() - lastLoopTime;
  
  if (gameState == 0) {
    drawMenu();
  }
  else if (gameState == 1) {
    mainGameLoop();
  }
  else if (gameState == 2) {
    drawGameOver();
  }
  lastLoopTime = millis();
}

void stop () {
  music.close();
  minim.stop();
  super.stop();
}

