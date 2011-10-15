




void drawMenu() {
  background(0);
  
  imageMode(CENTER);
  image(medusaTitleImage, width/2, height/2-100, 771, 106);
  //text("Medusa's Mirror", width/2, height/2-100);
  
  image(startGameImage, width/2, height/2+100, 539, 113);
  
  //text("New Game", width/2, height/2+100);
  
  if (mousePressed && mouseX >= (width/2) - 200 && mouseX <= (width/2) + 200 && mouseY >= (height/2) + 40 && mouseY <= (height/2) + 120) {
      startNewGame();
      gameState = 1;
    }
    
  if (keyPressed && (key == 365)){
    startNewGame();
    gameState = 1;
  }
}

void drawGameOver() {
  //background(0);
  imageMode(CENTER);
  image(gameOverImage, width/2, height/2, 482, 112);
  //text("Game Over", width/2, height/2+300);
  
  if (mousePressed && mouseX >= (width/2) - 200 && mouseX <= (width/2) + 200 && mouseY >= (height/2) -50 && mouseY <= (height/2) +50) {
      medusaDeath3.trigger();
      startNewGame();
      gameState = 0;
    }
 
}
