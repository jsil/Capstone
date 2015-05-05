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

  boolean inSubMenu = false;
  boolean SAFEMODE = false;

  GameManager() {
  }

  void draw() {
    if (gameMode == 0) {
      if (!inSubMenu) {
        drawMainMenu();
      } else {
        drawSubMenu();
      }
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

//      blendMode(BLEND);

//      pushMatrix();
//      translate(1110, 86, 150);
//      popMatrix();


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
    if ((SAFEMODE && !isVulgar(status)) || !SAFEMODE) {
      if (this.getGameMode() == 1 && game1.isActive()) {
        game1.addTweet(status);
      } else if (this.getGameMode() == 2) {
        tweetDeck.addToQueue(status);
      } else if (this.getGameMode() == 3) {
        game2.addToQueue(status);
      }
    } else {
      if (DEBUG)
        println("obscenity removed");
    }
  }

  boolean isVulgar(Status status) {
    String message = status.getText();
    if (message.indexOf("fuck") != -1 || message.indexOf("shit") != -1 || message.indexOf("nigg") != -1) {
      return true;
    } else {
      return false;
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
    makeSelection(selection);
  }

  void makeSelection(int sel) {
    if (!inSubMenu) {
      if (sel != 4)
        loadGameMode(sel);
      else {
        inSubMenu = true;
        numSelections = 3;
      }
      selection = 1;
    } else {
      if (sel == 1) {
        SAFEMODE = !SAFEMODE;
      } else if (sel == 2) {
        DEBUG = !DEBUG;
      }
    }
  }

  void backMenu() {
    if (inSubMenu) {
      inSubMenu = false;
      selection = 1;
      numSelections = 4;
    }
  }

  void drawMainMenu() {
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
      noTint();
    }
    if (selection == 2) {
      tint(60);
      rect(width/4, 220, width/4, height-220);
      noTint();
    }
    if (selection == 3) {
      tint(60);
      rect(width/2, 220, width/4, height-220);
      noTint();
    }
    if (selection == 4) {
      tint(60);
      rect(width*.75, 220, width/4, height-220);
      fill(255);
      textAlign(CENTER);
      text("Sub-Menu", width*.875, height/2);
      textAlign(LEFT);
      noTint();
    } else {
      noTint();
      textAlign(CENTER);
      fill(255);
      text("Sub-Menu", width*.875, height/2);
      textAlign(LEFT);
    }

    stroke(0);
    noTint();
    popMatrix();
  }

  boolean isInSubMenu() {
    return inSubMenu;
  }

  void drawSubMenu() {
    pushMatrix();
    background(48, 55, 95);

    fill(255);
    stroke(0);
    rect(width/6, (height/8)*1, 125, 125);
    if (SAFEMODE) {
      line(width/6, (height/8)*1, width/6+125, (height/8)*1+125);
      line(width/6+125, (height/8)*1, width/6, (height/8)*1+125);
    }
    text("\"Safe-Mode\" - Filters out tweets containing common obscenities.\n*NOTE* Offensive Language may still be visible even with Safe-Mode turned on!", width/6+175, (height/8)*1+75);

    rect(width/6, (height/8)*3, 125, 125);

    if (DEBUG) {
      line(width/6, (height/8)*3, width/6+125, (height/8)*3+125);
      line(width/6+125, (height/8)*3, width/6, (height/8)*3+125);
    }
    text("\"Debug\" - Toggles on screen debug window, as well as some handy print-line statements!", width/6+175, (height/8)*3+75);


    rect(width/6, (height/8)*5, 125, 125);

    if (selection == 1) {
      noFill();
      stroke(0);
      rect(width/6, (height/8)*1, (width/6)*4, 125);
    } else if (selection == 2) {
      noFill();
      stroke(0);
      rect(width/6, (height/8)*3, (width/6)*4, 125);
    } else if (selection == 3) {
      noFill();
      stroke(0);
      rect(width/6, (height/8)*5, (width/6)*4, 125);
    }

    popMatrix();
  }
}

