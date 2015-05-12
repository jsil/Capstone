class HashTag {

  private ArrayList<Tweet> tweetList = new ArrayList<Tweet>();
  int tweetLimit = 120;
  
  float timeLimit = 1.5 * 60 * 24;
  float currentTime = 0;

  Tweet theOne;

  HashTag() {
  }

  void draw() {
    currentTime++;
    handleHands();
    for (int i=0; i<tweetList.size (); i++) {
      Tweet tweet = tweetList.get(i);
      pushMatrix();
      if (!tweet.isPositioned()) {
        tweet.setPosition(random(displayWidth - tweet.getWidth()), random(displayHeight - tweet.getHeight()));
      }
      translate(tweet.getXPosition(), tweet.getYPosition(), tweet.getZPosition());
      tweet.drawHash(); 
      popMatrix();
    }
  }

  void handleHands() {
    ArrayList<Integer> allHands = hands.getAllHands();
    for (int i=0; i<allHands.size (); i++) { 
      float x = hands.getMappedXPos(allHands.get(i));
      float y = hands.getMappedYPos(allHands.get(i));
      println("Hand # " + allHands.get(i) + " x: " + x + " y: " + y);
      for (int j=0; j<tweetList.size (); j++) {
        Tweet tweet = tweetList.get(j);
        if(tweet.isTheOne()) {
           if (abs(x-tweet.getXPosition()) < 20) {
             if (abs(y-tweet.getYPosition()) < 20) {
               tweetList.remove(j);
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

