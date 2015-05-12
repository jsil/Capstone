/* bugs:
 if URL is unreachable, crashes
 "out of bound index: 0 size: 0"
 
 */

class RhythmTweet {

  ArrayList<TweetLane> lanes = new ArrayList<TweetLane>();

  TweetSort tweetSort = new TweetSort();
  Queue<Tweet> tweetQueue = new PriorityQueue(100, tweetSort);

  ArrayList<PImage[]> backgroundArr = new ArrayList<PImage[]>();
  int backgroundX = 28;
  int backgroundY = 16;

  int perceivedSize = 100;

  int laneNum = 3;

  float time = 0;
  
  float roundTime = 0;
  float timeLimit = 20*24;
  
  boolean takingScreenShot = false;

  int forced = -1;

  int points = 0;

  RhythmTweet() {
    for (int i=0; i<laneNum; i++) {
      lanes.add(new TweetLane(i));
      println("creating lane " + i);
    }

    for (int i=0; i<backgroundX; i++) {
      backgroundArr.add(new PImage[backgroundY]);
    }
  }

  void addToQueue(Status status) {
    tweetQueue.add(new Tweet(status, 2));
  }

  void addPoint() {
    points++;
  } 

  void subtractPoint() {
    if (points != 0) {
      points--;
    }
  }

  int getForced() {
    return forced;
  }

  void setForced(int set) {
    forced = set;
  }

  void drawBackground() {
    pushMatrix();
    translate(-655, -410, -701);
    for (int i=0; i<backgroundArr.size (); i++) {
      pushMatrix();
      for (int j=0; j<backgroundY; j++) {
        PImage image = backgroundArr.get(i)[j];
        if (image != null) {
          image(image, 0, 0);
        }
        translate(0, perceivedSize, 0);
      }
      popMatrix();
      translate(perceivedSize, 0, 0);
    }
    popMatrix();

    //   if (background != null) {
    //      println("trying to draw background");
    //      //       background(background); 
    //      pushMatrix();
    //      imageMode(CENTER);
    //      translate(0, 0, -800);
    //      image(background, width/2, height/2);
    //      imageMode(CORNER);
    //      println("did it");
    //      popMatrix();
    //    } else {
    //    }
  }

  void takeScreenShot() {
    saveFrame("../screenshots/####.png");
    println("took screenshot!");
    takingScreenShot = false;
  }


  void draw() {
    drawBackground();
    //    println("trying to draw rhythm");
    if(takingScreenShot) {
       takeScreenShot(); 
    }
    else {
      pushMatrix();
      fill(255);
      rect(0, 0, 50, 25);
      fill(0);
      text(points, 15, 15);
      moveTweets();
      int laneSelection = -1;
      if (hands.getFirstHand() != null) {
        laneSelection = hands.getTrinarySelection(hands.getFirstHand().getHandId());
        //      println("lane selection: " + laneSelection);
      } else {
        //      println("hand lost");
      }

      if (getForced() != -1) {
        laneSelection = getForced();
      }
      pushMatrix();
      translate(width/4, height*.9, 0);

      strokeWeight(3);
      if (laneSelection != -1) {
        stroke(80);
        if (laneSelection == 1) {
          lanes.get(0).setSelected(true);
          lanes.get(1).setSelected(false);
          lanes.get(2).setSelected(false);
          stroke(255);
        }
        line(width*.02, 0, width*.12, 0);
        line(width*.02, 0, width*.02, -10);
        line(width*.12, 0, width*.12, -10);

        stroke(80);
        if (laneSelection == 2) {
          lanes.get(0).setSelected(false);
          lanes.get(1).setSelected(true);
          lanes.get(2).setSelected(false);
          stroke(255);
        }
        line(width*.20, 0, width*.30, 0);
        line(width*.20, 0, width*.20, -10);
        line(width*.30, 0, width*.30, -10);

        stroke(80);
        if (laneSelection == 3) {
          lanes.get(0).setSelected(false);
          lanes.get(1).setSelected(false);
          lanes.get(2).setSelected(true);
          stroke(255);
        }
        line(width*.38, 0, width*.48, 0);
        line(width*.38, 0, width*.38, -10);
        line(width*.48, 0, width*.48, -10);
      } else {
        stroke(80);
        line(width*.02, 0, width*.12, 0);
        line(width*.02, 0, width*.02, -10);
        line(width*.12, 0, width*.12, -10);

        line(width*.20, 0, width*.30, 0);
        line(width*.20, 0, width*.20, -10);
        line(width*.30, 0, width*.30, -10);

        line(width*.38, 0, width*.48, 0);
        line(width*.38, 0, width*.38, -10);
        line(width*.48, 0, width*.48, -10);
      }
      popMatrix();

      translate(0, height*.4, -600);

      //    camera(width/2.0, 0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
      //    translate(width/3, 100);
      for (int i=0; i<lanes.size (); i++) {

        translate(width/4, 0);

        pushMatrix();
        lanes.get(i).draw();
        popMatrix();
      } 



      //    camera();//reset camera
      popMatrix();
    }
    roundTime++;
    if (roundTime >= timeLimit) {
      roundTime = 0;
      println("hit round time");
      takingScreenShot = true;
    }
  }

  void setTime(int timeSet) {
    time = timeSet;
    if (time == 0) {
      moveTweets();
    }
  }


  void moveTweets() {
    if (tweetQueue.size() > 0) {
//      println("trying to move tweet");
      Tweet newTweet = tweetQueue.poll();
      int lane = (int)random(laneNum);

      //      println("adding tweet to lane " + lane);
      lanes.get(lane).addTweet(newTweet);

      //      for (int i=0; i<lanes.size (); i++) {
      //        lanes.get(i).addTweet(tweetQueue.poll());
      //      }
//      println("moved tweet to lane " + lane);
    }
  }

  void addToBackground(PImage set) {
    int x = (int)random(backgroundX);
    int y = (int)random(backgroundY);
    //    println("x: " + x + " y: " + y);
    if ( backgroundArr.get(x)[y] == null) {
      set.resize(100, 100);
      backgroundArr.get(x)[y] = set;
    } else {
      addToBackground(set);
    }
  }

  void subtractFromBackground() {
    if (points != 0) {
      int x = (int)random(backgroundX);
      int y = (int)random(backgroundY);
      println("x: " + x + " y: " + y);
      if ( backgroundArr.get(x)[y] != null) {
        backgroundArr.get(x)[y] = null;
      } else {
        subtractFromBackground();
      }
    }
  }
}

