class RhythmTweet {

  ArrayList<TweetLane> lanes = new ArrayList<TweetLane>();

  TweetSort tweetSort = new TweetSort();
  Queue<Tweet> tweetQueue = new PriorityQueue(100, tweetSort);

  PImage background;

  int laneNum = 3;

  int time;

  RhythmTweet() {
    for (int i=0; i<laneNum; i++) {
      lanes.add(new TweetLane(i));
      println("creating lane " + i);
    }
  }

  void addToQueue(Status status) {
    tweetQueue.add(new Tweet(status, 2));
  }


  void draw() {
    if (background != null) {
      println("trying to draw background");
      //       background(background); 
      pushMatrix();
      imageMode(CENTER);
      translate(0,0,-800);
      image(background, width/2, height/2);
      imageMode(CORNER);
      println("did it");
      popMatrix();
    } else {
    }
    //    println("trying to draw rhythm");
    pushMatrix();
    moveTweets();
    int laneSelection = -1;
    if (hands.getFirstHand() != null) {
      laneSelection = hands.getTrinarySelection(hands.getFirstHand().getHandId());
      //      println("lane selection: " + laneSelection);
    } else {
      println("hand lost");
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

  void setTime(int timeSet) {
    time = timeSet;
    if (time == 0) {
      moveTweets();
    }
  }


  void moveTweets() {
    Tweet newTweet = tweetQueue.poll();
    if (newTweet != null) {
      int lane = (int)random(laneNum);

      //      println("adding tweet to lane " + lane);
      lanes.get(lane).addTweet(newTweet);

      //      for (int i=0; i<lanes.size (); i++) {
      //        lanes.get(i).addTweet(tweetQueue.poll());
      //      }
    }
  }

  void setBackground(PImage set) {
    background = set; 
//    background.resize(width/2, height/2);
  }
}

