class GameManager {

  private ThisOrThat game1;
  private RhythmTweet game2;

  private boolean paused = true;
  public boolean SAFEMODE = false;
  public boolean SHOWINTROS = false;
  private boolean inSubMenu = false;

  private int gameMode = 0;
  //gameMode 0 = menu
  //1 = this/that

  private int selection = 1;
  private int numSelections = 4;

  private PImage title = loadImage("title.png");
  private PImage totImage = loadImage("thisorthat.png");
  
  Intro intro1 = new Intro();
  boolean shownIntro1 = false;


  GameManager() {
  }

  public void draw() {
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
      if(!shownIntro1 && SHOWINTROS) {
        intro1.draw();
        if(intro1.isDone()) {
           shownIntro1 = true; 
        }
      }
      else {
        game1.draw();
      }
      
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
      
    }
    drawKinect(gameMode);
  }

  public int getGameMode() {
    return gameMode;
  }

  private void setGameMode(int gameModeSet) {
    gameMode = gameModeSet;
  }

  public void loadGameMode(int mode) {
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
      game2 = new RhythmTweet(3);

      paused = false;
    }
  }

  public boolean getPaused() {
    return paused;
  }

  public void pause() {
    paused = true;
  }

  public void unpause() {
    paused = false;
  }

  public void setTime(int val) {
    if (this.getGameMode() == 3) {
      game2.setTime(val);
    }
  }

  public void addTweet(Status status) {
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

  public boolean isVulgar(Status status) {
    String message = status.getText();
    if (message.indexOf("fuck") != -1 || message.indexOf("shit") != -1 || message.indexOf("nigg") != -1) {
      return true;
    } else {
      return false;
    }
  }

  public void setSelection(int selection) {
    this.selection = selection;
  }

  public void incrementSelection(boolean direction) {
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

  public void makeSelection() {
    makeSelection(selection);
  }

  public void makeSelection(int sel) {
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
      } else if (sel == 3) {
         SHOWINTROS = !SHOWINTROS; 
      }
    }
  }

  public void backMenu() {
    if (inSubMenu) {
      inSubMenu = false;
      selection = 1;
      numSelections = 4;
    }
  }

  private void drawMainMenu() {
    pushMatrix();
    background(48, 55, 95);
    imageMode(CENTER);
    image(title, width/2, 130);
    noFill();
    //320,430
    
    if(hands.getHand(1) != null) {
       text(hands.getQuadrantSelection(1),width/2,20);
    }
    
    translate(width*.2,220,0);
    rect(0,0,width*.6,height-300);
    
    line(width*.3,0,width*.3,height-300);
    line(0,(height-300)/2,width*.6,(height-300)/2);
    
//    rect(0, 220, width, height-220);
//    line(width/4, 220, width/4, height);
//    line(width/2, 220, width/2, height);
//    line(width*.75, 220, width*.75, height);
//
    imageMode(CORNER);
//    if (selection == 1) {
//      fill(40);
//      rect(0, 220, width/4, height-220);
//      noTint();
//      noStroke();
//      image(totImage, 0, 220, width/4, height-220);
//    } else {
//      fill(40);
//      rect(0, 220, width/4, height-220);
//      tint(60);
//      image(totImage, 0, 220, width/4, height-220);
//      noTint();
//    }
//    if (selection == 2) {
//      tint(60);
//      rect(width/4, 220, width/4, height-220);
//      noTint();
//    }
//    if (selection == 3) {
//      tint(60);
//      rect(width/2, 220, width/4, height-220);
//      noTint();
//    }
//    if (selection == 4) {
//      tint(60);
//      rect(width*.75, 220, width/4, height-220);
//      fill(255);
//      textAlign(CENTER);
//      text("Sub-Menu", width*.875, height/2);
//      textAlign(LEFT);
//      noTint();
//    } else {
//      noTint();
//      textAlign(CENTER);
//      fill(255);
//      text("Sub-Menu", width*.875, height/2);
//      textAlign(LEFT);
//    }

    stroke(0);
    noTint();
    popMatrix();
    
  }

  public boolean isInSubMenu() {
    return inSubMenu;
  }

  private void drawSubMenu() {
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
    
    if (SHOWINTROS) {
      line(width/6, (height/8)*5, width/6+125, (height/8)*5+125);
      line(width/6+125, (height/8)*5, width/6, (height/8)*5+125);
    }
    text("\"Show Intros\" - Toggles intro display", width/6+175, (height/8)*5+75);


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
  
  
  void addUser(int id) {
    if (gameMode == 1) {
      game1.addUser(id);
    }
  }
  
  void lostUser(int id) {
    if (gameMode == 1) {
     game1.lostUser(id);
    }
  }
}

