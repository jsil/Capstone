class GameManager {

  public ThisOrThat game1;
  public RhythmTweet game2;

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
  private PImage menuImage1 = loadImage("thisorthat.png");
  private PImage menuImage2 = loadImage("tweetbeat.png");
  private PImage menuImage4 = loadImage("optionsmenu.png");

  Intro intro1 = new Intro();
  boolean shownIntro1 = false;


  int selectionTime = 0;
  float selectionTimeMax = 3.5 * 24;
  int currentSelection;

  float kinectWidth = 0;
  float kinectHeight = 0;

  GameManager() {
  }

  void drawSelectionCircle(int num) {
    pushMatrix();
    switch(num) {
    case 1: 
      translate(kinectWidth/4, kinectHeight*.25, 0);
      break;
    case 2: 
      translate(kinectWidth*.75, kinectHeight*.25, 0);
      break;
    case 3: 
      translate(kinectWidth/4, kinectHeight*.75, 0);
      break;
    case 4: 
      translate(kinectWidth*.75, kinectHeight*.75, 0);
      break;
    }
    pushMatrix();
    rotate(-PI/2);
    stroke(0);
    strokeWeight(3);
    noFill();
    arc(0, 0, 80, 80, 0, 2*PI, PIE);
    fill(255);
    
    int selectionTimeFixed = 1;
    String selectionTimeFixed2;
    if(selectionTime == 0) {
       selectionTimeFixed = 1; 
       selectionTimeFixed2 = "0";
    }
    else {
       selectionTimeFixed = selectionTime; 
//       if(selectionTime <= 24) {
//         selectionTimeFixed2 = "1";
//       }
//       else {
         selectionTimeFixed2 = nf(((float)selectionTime/24)/4,0,2) + "%";
//       }
    }
//    println("time: " + selectionTime + " out of " + selectionTimeMax + " = " + (float)selectionTimeFixed/selectionTimeMax);
    arc(0, 0, 80, 80, 0, (float)2*PI/((float)selectionTimeMax/selectionTimeFixed), PIE);
    popMatrix();
    fill(0);
    println("time " + selectionTimeFixed2);
    textFont(defaultFont,20);
    textAlign(CENTER);
//    translate(0,0,3);
    text((selectionTimeFixed2),0,0);
    textAlign(LEFT);
//    text("time " + (selectionTimeFixed2),215,255);
    noFill();
    strokeWeight(1);
    popMatrix();
    println("time " + selectionTimeFixed2);
    
  }

  void handleHands() {
    ArrayList<Integer> handIds = hands.getAllHands();
    //all hands must be on selection to make it
    for (int i=0; i<handIds.size (); i++) {
      Hand hand = hands.getHand(handIds.get(i));
      text(hands.getQuadrantSelection2(hand.getHandId()), width/2, 20);
      int selection = hands.getQuadrantSelection2(hand.getHandId());
      if (selection != -1) {
        if (currentSelection != selection) {
          currentSelection = selection;
          selectionTime = 0;
        } else {
          selectionTime++;
          if (selectionTime >= selectionTimeMax) {
            loadGameMode(selection);
          }
          drawSelectionCircle(selection);
        }
      }
      else {
        currentSelection = -1;
        selectionTime = 0;
      }
    }
  }

  public void draw() {
    beginCamera();
//    camera(0.0, 0.0, 100.0, 0.0, 0.0, 0.0, 
//       0.0, 1.0, 0.0);
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
      if (!shownIntro1 && SHOWINTROS) {
        intro1.draw();
        if (intro1.isDone()) {
          shownIntro1 = true;
        }
      } else {
        game1.draw();
      }

      popMatrix();
    } else if (gameMode == 2) {
      pushMatrix();
      background(15, 23, 30);
      game2.draw();
      popMatrix();
    } else {

      pushMatrix();
      textFont(defaultFont);
      translate(0, 0, -150);
//      vis.draw();

      popMatrix();
    }
    endCamera();
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
      game2 = new RhythmTweet();
      hands.limitOne(true);
      
      paused = false;
    } else if (mode == 3) {
      this.setGameMode(mode);

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
//        println("adding tweet to tweet beat");
        game2.addToQueue(status);
      } else if (this.getGameMode() == 3) {
//        game2.addToQueue(status);
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

    translate(width*.2, 220, 0);
    
    handleHands();
    
    kinectWidth = width*.6;
    kinectHeight = height-300;
    
    rect(0, 0, kinectWidth, kinectHeight);

    line(kinectWidth/2, 0, kinectWidth/2, kinectHeight);
    line(0, kinectHeight/2, kinectWidth, kinectHeight/2);

    //    rect(0, 220, width, height-220);
    //    line(width/4, 220, width/4, height);
    //    line(width/2, 220, width/2, height);
    //    line(width*.75, 220, width*.75, height);
    //
    imageMode(CORNER);
//        if (selection == 1) {
//          fill(40);
//          rect(0, 220, width/4, height-220);
          noTint();
          noStroke();
          fill(150);
          rect(0,0,kinectWidth/2, kinectHeight/2);
          image(menuImage1, 0, 0, kinectWidth/2, kinectHeight/2);
          
          rect(kinectWidth/2,0,kinectWidth/2, kinectHeight/2);
          image(menuImage2, kinectWidth/2, 0, kinectWidth/2, kinectHeight/2);
          
          rect(kinectWidth/2,kinectHeight/2,kinectWidth/2, kinectHeight/2);
          image(menuImage4, kinectWidth/2, kinectHeight/2, kinectWidth/2, kinectHeight/2);
//        } 
    //else {
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

