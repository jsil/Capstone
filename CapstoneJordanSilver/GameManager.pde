class GameManager {


  ThisOrThat game1;
  RhythmTweet game2;

  private int gameMode = 0;
  //gameMode 0 = menu
  //1 = this/that

  private boolean paused = true;

  GameManager() {
  }

  void draw() {
    if (gameMode == 0) {
      pushMatrix();
      background(48, 55, 95);
      text("To Do: Add Menu", displayWidth/2-10, 300);
      popMatrix();
    } else if (gameMode == 1) {
      pushMatrix();
      background(48, 55, 95);
      //text("Game 1", displayWidth/2-10, 15);
      game1.draw();
      popMatrix();
    } else if (gameMode == 3) {
      pushMatrix();
      background(15, 23, 30);
      game2.draw();
      popMatrix();
    } else {

      pushMatrix();
      textFont(defaultFont);
      translate(0, 0, -150);
      vis.draw();

      popMatrix();

      blendMode(BLEND);

      pushMatrix();
      translate(1110, 86, 150);
      popMatrix();


      if (!paused) {
        drawKinect();
        drawTwitter();
        drawCamera();
      }
    }
  }

  int getGameMode() {
    return gameMode;
  }

  void setGameMode(int gameModeSet) {
    gameMode = gameModeSet;
  }

  void loadGameMode(int mode) {
    println("Loading Game " + mode);
    if (mode == 0) {
      this.setGameMode(mode);
    } else if (mode == 1) {
      this.setGameMode(mode);
      game1 = new ThisOrThat();

      paused = false;
    } else if (mode == 2) {
      this.setGameMode(mode);
      paused = false;
    } else if (mode == 3) {
      this.setGameMode(mode);
      game2 = new RhythmTweet(2);

      paused = false;
    }

    //doKinect();
  }

  boolean getPaused() {
    return paused;
  }

  void pause() {
    paused = true;
  }

  void unpause() {
    paused = false;
  }

  void setTime(int val) {
    if (this.getGameMode() == 3) {
      game2.setTime(val);
    }
  }

  void addTweet(Status status) {
    if (this.getGameMode() == 1) {
      game1.addTweet(status);
    } else if (this.getGameMode() == 2) {
      tweetDeck.addToQueue(status);
    } else if (this.getGameMode() == 3) {
      game2.addToQueue(status);
    }
  }
}

