/* TO DO:
 find more words
 add points system
 */

class ThisOrThat {

  private ArrayList<Integer> handIds = new ArrayList<Integer>();
  private ArrayList<Tweet> tweetList = new ArrayList<Tweet>();
  private ArrayList<int[]> postStats = new ArrayList<int[]>();
  private ArrayList<String[]> allWords = new ArrayList<String[]>();

  //  ArrayList<int> scores = new ArrayList<int>();


  private String word1;
  private String word2;

  int round = 1;
  int totalRounds = 5;


  private int dataInterval = 4;
  private float timeSinceData = 0;
  private float roundTime = dataInterval * 5;
  private float timeRemaining = roundTime;


  float endTime = 6;
  float endTimeRemaining = endTime;


  private int count1 = 0;
  private int count2 = 0;

  private color color1 = color(255, 0, 0);
  private color color2 = color(47, 66, 120);
  private color color3 = color(0, 0, 0);

  private PFont timerFont = loadFont("timerFont.vlw");

  private boolean active = false;

  private boolean roundEnded = false;

//  Intro intro = new Intro();

  ThisOrThat() {
    loadWords();
    generateNewWords();
    //        word1 =  "bed";
    //        word2 = "bath";
    ArrayList<Integer> initialHands = hands.getAllHands();
    for (int i = 0; i< initialHands.size (); i++) {
      addUser(initialHands.get(i));
      println("adding initial hand");
    }
  }

  void awardPoints() {
    //    println("awarding points");
    for (int i=0; i<handIds.size (); i++) {
      //      println("hand " + handIds.get(i));
      Hand hand = hands.getHand(handIds.get(i));

      int diff1; 
      int diff2; 

      if (postStats.size() > 1) {
        diff1 = postStats.get(postStats.size()-1)[0] - postStats.get(postStats.size()-2)[0];
        diff2 = postStats.get(postStats.size()-1)[1] - postStats.get(postStats.size()-2)[1];
      } else {
        diff1 = postStats.get(0)[0];
        diff2 = postStats.get(0)[1];
      }

      println("diff 1: " + diff1);
      println("diff 2: " + diff2);

      //      println("hand# " + hand.getHandId());
      //      int handNum = hand.getHandId();
      if (hands.getBinarySelection(handIds.get(i))) {
        if (count2 >= count1) {
          //               scores.get(i) = scores.get(i) + 1; 
          hand.addPoints(1);
          //          println("one ");
        }
        if (diff2 >= diff1) {
          hand.addPoints(2);
        }
      } else {
        if (count1 >= count2) {
          hand.addPoints(1);
          //              scores.get(i) += 1;
          //          println("two ");
        }
        if (diff1 >= diff2) {
          hand.addPoints(2);
        }
      }
    }
  }

  void addUser(int id) {
    handIds.add(id);
  }

  void lostUser(int id) {
    for (int i=0; i<handIds.size (); i++) {
      if (handIds.get(i) == id) {
        handIds.remove(i);
        break;
      }
    }
  }

  public void addTweet(Status status) {
    Tweet tweet = new Tweet(status, 1);
    tweetList.add(tweet);
    if (tweet.contains(word1)) {
      count1++;
    }
    if (tweet.contains(word2)) {
      count2++;
    }
  }

  void drawScores() {
    textFont(defaultFont);
    pushMatrix();
    translate(0, height/2, 0);
    fill(40);
    rect(0, 0, 80, 120);
    fill(255);
    text("Scores:", 15, 15);

    for (int i=0; i<handIds.size (); i++) {
      Hand hand = hands.getHand(handIds.get(i));
      text(hand.getHandId() + " - " + hand.getScore(), 15, 40 + i*15);
    }
    popMatrix();
  }

  public void draw() {
    if (timeRemaining > 0) {
      timeRemaining = timeRemaining - 1/frameRate;
      timeSinceData = timeSinceData + 1/frameRate;
      active = true;
    }
    if (timeRemaining <= 0) {
      endRound();
    }

    textFont(defaultFont, 24);
    stroke(255);
    drawScores();

    //line(displayWidth/2, 0, displayWidth/2, displayHeight);
    line(0, 100, width, 100);

    fill(color1);
    rect(0, 0, width/2-100, 100);
    fill(color2);
    rect(width/2+100, 0, width/2-100, 100);

    fill(255);
    
    textFont(timerFont);

    textAlign(CENTER);
    text(word1, width/4, 65);
    text(word2, 3*(width/4), 65);
    textAlign(LEFT);
    textFont(defaultFont);

    pushMatrix();
    translate(width/2, 0, 0);

    noFill();
    rectMode(CENTER);
    rect(0, 50, 200, 100);

    rectMode(CORNER);


    fill(255);
    textFont(timerFont, 42);    
    text((int)timeRemaining, -80, 65);


    rotate(-PI/2);
    stroke(0);
    strokeWeight(3);
    noFill();
    arc(-50, 35, 80, 80, 0, 2*PI, PIE);
    fill(255);

    if ((timeSinceData < .5 || timeSinceData > (float)(dataInterval*24) - 1) && (roundTime - timeRemaining) > .8) {
      fill(255, 0, 0);
//      text("Points awarded", 0, 250);
    }


    arc(-50, 35, 80, 80, 0, 2*PI*(1-abs((timeRemaining-roundTime)/roundTime)), PIE);
    strokeWeight(1);
    popMatrix();



    //      if (timeSinceData >= dataInterval) {
    if (timeRemaining % dataInterval < 0.04 && active) {
      timeSinceData = 0;
      //println("adding stats");
      postStats.add(new int[] {
        count1, count2
      }
      );
      awardPoints();
    }


    if (timeRemaining>0) {
      translate(0, 0, 100);
      for (int i=tweetList.size ()-1; i>=0; i--) {
        Tweet tweet = tweetList.get(i);

        if (!tweet.isPositioned()) {//if tweet hasn't been drawn, assign color & random position
          tweet.setPosition(random(displayWidth-tweet.getWidth()), 100+ random(displayHeight-tweet.getHeight() - 150));
          if (tweet.contains(word1)) {
            if (!tweet.contains(word2)) {
              tweet.setColor(color1);
            } else {
              tweet.setColor(color3);
            }
          } else if (tweet.contains(word2)) {
            tweet.setColor(color2);
          }
        }
        if (tweet.contains(word1) || tweet.contains(word2)) {
          pushMatrix();
          translate(tweet.getXPosition(), tweet.getYPosition());
          tweet.draw();
          popMatrix();
          translate(0, 0, -100);
        }

        if (tweet.isDone()) {
          tweetList.remove(i);
        }
      }
    }

    for (int i=0; i<tweetList.size (); i++) {
      if (tweetList.get(i).isDone()) {
        tweetList.remove(i);
      }
    }

    if (timeRemaining <= 0) {  
      textAlign(CENTER);   
      fill(255); 
      if (count1 > count2) {
        text(word1 + " is the winner with " + count1 + " tweets!", width/2, 150);
      } else if (count1 < count2) {
        text(word2 + " is the winner with " + count2 + " tweets!", width/2, 150);
      } else {
        text(word1 + " and " + word2 + " tied with " + count1 + " tweets each!", width/2, 150);
      }
      textAlign(LEFT);
      drawGraph();
    }
    //    }
  }

  private void endRound() {
    if (!roundEnded) {
      roundEnded = true;
      active = false;
      //add final count
      //      postStats.add(new int[] {
      //        count1, count2
      //      }
      //      );
    }

    if (endTimeRemaining > 0) {
      endTimeRemaining = endTimeRemaining - 1/frameRate;
      fill(255);
//      text((int)endTimeRemaining, width/2, height/2);
//      text(round + "/" + totalRounds, width/2, height/2+20);
    }
    if (endTimeRemaining <= 0) {
      if (round < totalRounds) 
        newRound();
      else finalResults();
    }
  }

  public void newRound() {
    round++;
    active = true;
    roundEnded = false;
    timeRemaining = roundTime;
    endTimeRemaining = endTime;
    generateNewWords();
    count1 = 0;
    count2 = 0;
    postStats = new ArrayList<int[]>();
    tweetList = new ArrayList<Tweet>();
  }

  public void finalResults() {
    fill(255);
    text("Game Over", width/2, height/2);
    //to do: add gap
    gm.loadGameMode(0);
  }


  public boolean isActive() {
    return active;
  }

  private void drawGraph() {
    pushMatrix();
    translate(100, 200, 0);
    stroke(255);
    float graphH = height-320;
    line(0, 0, 0, graphH);
    line(0, graphH, width-200, graphH);
    int maxCount = count1;
    if (count2 > maxCount)
      maxCount = count2;

    pushMatrix();
    //TODO: add graph's Y labels
    popMatrix();

    translate(0, graphH, 0);

    float xJump = (width-200)/postStats.size();
    rectMode(CENTER);
    textAlign(CENTER);
    fill(255);
    text("0", 0, 40);
    for (int i=0; i<postStats.size (); i++) {
      translate(xJump, 0, 0);
      fill(255);
      text((i+1)*dataInterval, 0, 40);

      int c1 = postStats.get(i)[0];
      int c2 = postStats.get(i)[1];

      pushMatrix();
      if (count1 >= count2) {
        translate(0, 0, 1);
      }
      translate(0, 0 - (float)graphH*((float)c1/(float)maxCount), 0);
      fill(color1);
      rect(0, 0, 15, 15);
      translate(0, 0, -1);
      if (i > 0) {
        int prev = postStats.get(i-1)[0];
        line(0, 0, 1-xJump, (float)graphH*((float)c1/(float)maxCount) - (float)graphH*((float)prev/(float)maxCount));
      } else {
        line(0, 0, 1-xJump, (float)graphH*((float)c1/(float)maxCount));
      }
      popMatrix();

      pushMatrix();
      if (count1 < count2) {
        translate(0, 0, 1);
      }
      translate(0, 0 - (float)graphH*((float)c2/(float)maxCount), 0);
      fill(color2);
      rect(0, 0, 15, 15);
      translate(0, 0, -1);
      if (i > 0) {
        int prev = postStats.get(i-1)[1];
        line(0, 0, 1-xJump, (float)graphH*((float)c2/(float)maxCount) - (float)graphH*((float)prev/(float)maxCount));
      } else {
        line(0, 0, 1-xJump, (float)graphH*((float)c2/(float)maxCount));
      }
      popMatrix();
    }

    rectMode(CORNER);
    textAlign(LEFT);
    stroke(0);
    popMatrix();
  }

  public void generateNewWords() {
    if (allWords.size() > 0) {
      int rand = (int)random(allWords.size());
      word1 = allWords.get(rand)[0];
      word2 = allWords.get(rand)[1];
      allWords.remove(rand);
    } else {
      println("Error! No more words! Words not updated");
    }
  }

  public void loadWords() {
    allWords.add(new String[] {
      "dad", "sis"
    } 
    );
    //    allWords.add(new String[] {
    //      "black", "white"
    //    } 
    //    );
    //    allWords.add(new String[] {
    //      "husband", "wife"
    //    } 
    //    );
    //    allWords.add(new String[] {
    //      "aunt", "uncle"
    //    } 
    //    );
    //    allWords.add(new String[] {
    //      "bye", "hello"
    //    } 
    //    );
    allWords.add(new String[] {
      "want", "need"
    } 
    );
    allWords.add(new String[] {
      "any", "help"
    } 
    );
    allWords.add(new String[] {
      "change", "stay"
    } 
    );
    allWords.add(new String[] {
      "wait", "stop"
    } 
    );
    allWords.add(new String[] {
      "movie", "song"
    } 
    );
    allWords.add(new String[] {
      "thanks", "come"
    } 
    );
  }
}

