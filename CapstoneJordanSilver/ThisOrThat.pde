/* TO DO:
 function when time hits 0
 end of round nonsense
 
 find more words
 
 */

class ThisOrThat {

  ArrayList<Tweet> tweetList = new ArrayList<Tweet>();

  ArrayList<int[]> postStats = new ArrayList<int[]>();

  String word1;
  String word2;

  float roundTime = 30;
  float timeRemaining = roundTime;

  int count1 = 0;
  int count2 = 0;

  color color1 = color(255, 0, 0);
  color color2 = color(47, 66, 120);

  PFont timerFont = loadFont("timerFont.vlw");

  boolean active = false;

  boolean roundEnded = false;

  /* good word combinations:
   sister - dad
   
   
   
   
   
   */

  ThisOrThat() {
    word1 = "sis";
    word2 = "dad";
  }

  void addTweet(Status status) {
    Tweet tweet = new Tweet(status);
    tweetList.add(tweet);
    if (tweet.contains(word1)) {
      count1++;
    }
    if (tweet.contains(word2)) {
      count2++;
    }
  }

  void draw() {

    //update timeRemaining
    if (timeRemaining > 0) {
      timeRemaining = timeRemaining - 1/frameRate;
      active = true;
    }
    if (timeRemaining <= 0) {
      endRound();
    }

    textFont(defaultFont, 24);

    //line(displayWidth/2, 0, displayWidth/2, displayHeight);
    line(0, 100, width, 100);

    fill(color1);
    rect(0, 0, width/2-100, 100);
    fill(color2);
    rect(width/2+100, 0, width/2-100, 100);

    fill(255);

    text(word1 + ": " + count1, width/4, 50);
    text(word2 + ": " + count2, 3*(width/4), 50);

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
    noFill();
    arc(-50, 35, 80, 80, 0, 2*PI, PIE);
    fill(255);
    arc(-50, 35, 80, 80, 0, 2*PI*(1-abs((timeRemaining-roundTime)/roundTime)), PIE);
    popMatrix();

    if (timeRemaining>0) {

      for (int i=0; i<tweetList.size (); i++) {
        Tweet tweet = tweetList.get(i);

        if (!tweet.isPositioned()) {//if tweet hasn't been drawn, assign color & random position
          tweet.setPosition(random(displayWidth-tweet.getWidth()), 100+ random(displayHeight-tweet.getHeight() - 150));
          if (tweet.contains(word1)) {
            tweet.setColor(color1);
          } else if (tweet.contains(word2)) {
            tweet.setColor(color2);
          }
        }
        if (tweet.contains(word1) || tweet.contains(word2)) {
          pushMatrix();
          translate(tweet.getXPosition(), tweet.getYPosition());
          tweet.draw();
          popMatrix();
          translate(0, 0, 1);
        }

        if (tweet.isDone()) {
          tweetList.remove(i);
        }
      }
    }

    if (timeRemaining % 5 < 0.04 && active) {
      println("adding stats");
      postStats.add(new int[] {
        count1, count2
      }
      );
    }

    for (int i=0; i<tweetList.size (); i++) {
      if (tweetList.get(i).isDone()) {
        tweetList.remove(i);
      }
    }

    if (timeRemaining <= 0) {      
      pushMatrix();
      translate(100, 200, 0);
      stroke(255);
      float graphH = height-300;
      line(0, 0, 0, graphH);
      line(0, graphH, width-200, graphH);
      int maxCount = count1;
      if (count2 > maxCount)
        maxCount = count2;
      println("size: " + postStats.size());
      translate(0, graphH, 0);
      
      float xJump = 150;
      rectMode(CENTER);
      for (int i=0; i<postStats.size (); i++) {
        translate(xJump, 0, 0);
        int c1 = postStats.get(i)[0];
        int c2 = postStats.get(i)[1];
        
        pushMatrix();
        if(count1 >= count2) {
           translate(0,0,1); 
        }
        translate(0, 0 - (float)graphH*((float)c1/(float)maxCount), 0);
        fill(color1);
        rect(0, 0, 15, 15);
        if(i > 0) {
           int prev = postStats.get(i-1)[0];
           line(0,0,1-xJump, (float)graphH*((float)c1/(float)maxCount) - (float)graphH*((float)prev/(float)maxCount));
        }
        else {
          line(0,0,1-xJump, (float)graphH*((float)c1/(float)maxCount));
        }
        popMatrix();

        pushMatrix();
        if(count1 < count2) {
           translate(0,0,1); 
        }
        translate(0, 0 - (float)graphH*((float)c2/(float)maxCount), 0);
        fill(color2);
        rect(0, 0, 15, 15);
        if(i > 0) {
           int prev = postStats.get(i-1)[1];
           line(0,0,1-xJump, (float)graphH*((float)c2/(float)maxCount) - (float)graphH*((float)prev/(float)maxCount));
        }
        else {
          line(0,0,1-xJump, (float)graphH*((float)c2/(float)maxCount));
        }
        popMatrix();
      }
      
      rectMode(CORNER);
      stroke(0);
      popMatrix();
    }
  }

  void endRound() {
    if (!roundEnded) {
      roundEnded = true;
      active = false;
      //add final count
//      postStats.add(new int[] {
//        count1, count2
//      }
//      );
    }
  }

  boolean isActive() {
    return active;
  }
}

