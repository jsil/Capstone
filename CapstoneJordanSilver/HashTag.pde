class HashTag {

  private ArrayList<Tweet> tweetList = new ArrayList<Tweet>();
  int tweetLimit = 120;

  float timeLimit = 1.5 * 60 * 24;
  float currentTime = 0;

  int points = 0;

  Tweet theOne;

  HashTag() {
  }

  void draw() {
    pushMatrix();
//    rect(0,0,70,50);
    textFont(defaultFont);
    text(points,25,25);
    currentTime++;
    handleHands();
    for (int i=0; i<tweetList.size (); i++) {
      Tweet tweet = tweetList.get(i);
      pushMatrix();
      if (!tweet.isPositioned()) {
        tweet.setPosition(random(displayWidth - tweet.getWidth()), random(displayHeight - tweet.getHeight()));
      }
      translate(tweet.getXPosition(), tweet.getYPosition(), 0);
      tweet.drawHash(); 
      if (tweet.isDone()) {
        tweetList.remove(i);
      }
      popMatrix();
    }
    popMatrix();
  }

  void handleHands() {
    ArrayList<Integer> allHands = hands.getAllHands();
    for (int i=0; i<allHands.size (); i++) { 
      float x = hands.getMappedXPos(allHands.get(i));
      float y = hands.getMappedYPos(allHands.get(i));
      println("Hand # " + allHands.get(i) + " x: " + x + " y: " + y);
      for (int j=0; j<tweetList.size (); j++) {
        Tweet tweet = tweetList.get(j);
        if (x-tweet.getXPosition() > 0 && tweet.getXPosition()+tweet.getWidth() - x > 0) {
          if (y-tweet.getYPosition() > 0 && tweet.getYPosition()+tweet.getHeight() - y > 0) {
            if (tweet.isTheOne()) {
              tweetList.remove(j);
              theOne = null;
              points++;
            }
            else {
               PVector push = hands.getDirectional(allHands.get(i));
               if(push.x > 50) {
                  tweet.pushX(true);
               }
               else if(push.x < 50){
                 tweet.pushX(false);
               }
               if(push.y > 50) {
                  tweet.pushY(false);
               }
               else if(push.y < 50){
                 tweet.pushY(true);
               }
//               tweet.pushRandom(); 
            }
          }
        }
      }
    }
  }

  public void addTweet(Status status) {
    if (status.getHashtagEntities().length != 0 && tweetList.size() < tweetLimit) {
      println("added hash");
      Tweet tweet = new Tweet(status, 3);
      tweetList.add(tweet);
      if (theOne == null) {
        theOne = tweet;
        tweet.theOne();
      }
    } else {
      //do nothing
    }
  }
}

