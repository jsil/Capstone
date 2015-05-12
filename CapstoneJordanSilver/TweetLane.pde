class TweetLane {


  ArrayList<Tweet> activeTweets = new ArrayList<Tweet>();

  int tweetNum = 5;

  //  float xPos;
  int laneNum;

  int angle = 55;

  int cooldown = 0;

  boolean isSelected = false;

  TweetLane(int laneNumSet) {
    laneNum = laneNumSet;
  }

  void draw() {
    pushMatrix();
//    text(laneNum, 0, -100);
    rotateX(radians(-angle));
    fill(127,127);
    noStroke();
//    tint(255, 127);
    pushMatrix();
    translate(0,50,300);
    box(220,0,900);
    popMatrix();
    for (int i=0; i<activeTweets.size (); i++) {
      pushMatrix();
      translate(0, 0, -100);
      translate(0, 0, activeTweets.get(i).getZPosition());
      rotateX(radians(angle));
      activeTweets.get(i).drawSmall();
      popMatrix();
      if (abs(700-activeTweets.get(i).getZPosition())<= 30 && isSelected) {
        //award points
        //set background
        if (activeTweets.get(i).isGood()) {
          gm.game2.addToBackground(activeTweets.get(i).getImage());
          gm.game2.addPoint();
//          println("hit good tweet!!");
        }
        else {
          gm.game2.subtractFromBackground();
          gm.game2.subtractPoint();
//          println("hit bad tweet!!");
        }
        activeTweets.remove(i);
      }
      if (activeTweets.get(i).isDone()) {
        activeTweets.remove(i);
      }
    }
    popMatrix();
    if (cooldown > 0) {
      cooldown --;
    }
  }

  boolean addTweet(Tweet newTweet) {
    if (activeTweets.size() < tweetNum && cooldown == 0) {
      //      println("trying to add tweet");
      activeTweets.add(newTweet);
      cooldown = 24;
      return true;
    } else {
      return false;
    }
  }

  void setSelected(boolean set) {
    isSelected = set;
  }
}

