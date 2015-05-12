class TweetLane {


  ArrayList<Tweet> activeTweets = new ArrayList<Tweet>();

  int tweetNum = 5;

  //  float xPos;
  int laneNum;

  int angle = 45;
  
  int cooldown = 0;

  TweetLane(int laneNumSet) {
    laneNum = laneNumSet;
  }

  void draw() {
    pushMatrix();
    text(laneNum, 0, -100);
    rotateX(radians(-angle));
    for (int i=0; i<activeTweets.size (); i++) {
      pushMatrix();
      translate(0, 0, -100);
      translate(0, 0, activeTweets.get(i).getZPosition());
      rotateX(radians(angle));
      activeTweets.get(i).drawSmall();
      popMatrix();
      if(activeTweets.get(i).isDone()) {
         activeTweets.remove(i); 
      }
    }
    popMatrix();
    if(cooldown > 0) {
       cooldown --; 
    }
  }

  boolean addTweet(Tweet newTweet) {
    if (activeTweets.size() < tweetNum && cooldown == 0) {
      println("trying to add tweet");
      activeTweets.add(newTweet);
      cooldown = 24;
      return true;
    } else {
      return false;
    }
  }
}

