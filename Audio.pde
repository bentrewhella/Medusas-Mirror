import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
Minim minim;
AudioPlayer music;
AudioSample gameStartSample;
AudioSample medusaDeath1;
AudioSample medusaDeath2;
AudioSample medusaDeath3;
AudioSample jasonDeath;
AudioSample medusaShoot;
AudioSample jasonReflect;
AudioSample laugh;
AudioSample medusaSpawn;
AudioSample footsteps;

void setUpAudio() {
  minim = new Minim(this);
  music = minim.loadFile("Greek_TitleScreenMusic.mp3");
  music.loop();
  gameStartSample = minim.loadSample("GreekSFX_GameStartVO.mp3");
  medusaDeath1 = minim.loadSample("GreekSFX_MedusaDeath2.wav");
  medusaDeath2 = minim.loadSample("GreekSFX_MedusaDeath3.wav");
  medusaDeath3 = minim.loadSample("GreekSFX_MedusaDeath4.wav");
  jasonDeath = minim.loadSample("GreekSFX_JasonDeath.wav");
  medusaShoot = minim.loadSample("GreekSFX_MedusaShoot.wav");
  jasonReflect= minim.loadSample("GreekSFX_JasonReflect.wav");
  laugh = minim.loadSample("GreekSFX_MedusaLaugh.wav");
  medusaSpawn = minim.loadSample("GreekSFX_SnakeRelease.wav");
  footsteps = minim.loadSample("Greek_FootstepLEFT+RIGHT.wav");
  laugh.trigger();
}

void startPlayingAudio () {
  music.close();
  music = minim.loadFile("Greek_InGameMusic.mp3");
  music.loop();
  gameStartSample.trigger();
}

void endMusic () {
  music.close();
  music = minim.loadFile("Greek_EndofLevel.mp3");
  music.play();
}

