class GameManager {


  ThisOrThat game1;
  RhythmTweet game2;

  private int gameMode = 0;
  //gameMode 0 = menu
  //1 = this/that

  private boolean paused = true;
  PImage title = loadImage("title.png");
  PImage totImage = loadImage("thisorthat.png");

  int selection = 1;
  int numSelections = 4;

  GameManager() {
  }

  void draw() {
    if (gameMode == 0) {
      pushMatrix();
      background(48, 55, 95);
      //      text("To Do: Add Menu", displayWidth/2-10, 300);
      imageMode(CENTER);
      image(title, width/2, 130);
      noFill();
      //320,430
      rect(0, 220, width, height-220);
      line(width/4, 220, width/4, height);
      line(width/2, 220, width/2, height);
      line(width*.75, 220, width*.75, height);

      imageMode(CORNER);


      if (selection == 1) {
        fill(40);
        rect(0, 220, width/4, height-220);
        noTint();
        noStroke();
        image(totImage, 0, 220, width/4, height-220);
      } else {
        fill(40);
        rect(0, 220, width/4, height-220);
        tint(60);
        image(totImage, 0, 220, width/4, height-220);
        if (selection == 2) {
          rect(width/4, 220, width/4, height-220);
        } else if (selection == 3) {
          rect(width/2, 220, width/4, height-220);
        } else if (selection == 4) {
          rect(width*.75, 220, width/4, height-220);
        }
      }

      stroke(0);
      noTint();
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
    if (this.getGameMode() == 1 && game1.isActive()) {
      game1.addTweet(status);
    } else if (this.getGameMode() == 2) {
      tweetDeck.addToQueue(status);
    } else if (this.getGameMode() == 3) {
      game2.addToQueue(status);
    }
  }

  void setSelection(int selection) {
    this.selection = selection;
  }

  void incrementSelection(boolean direction) {
    if (!direction) {//left
      selection--;
      if (selection <= 0)
        selection = 1;
    } else {//right
      selection++;
      if (selection > numSelections)
        selection = numSelections;
    }
  }

  void makeSelection() {
    loadGameMode(selection);
  }

  void makeSelection(int sel) {
    loadGameMode(sel);
  }
}

