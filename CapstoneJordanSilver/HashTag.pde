class HashTag {

  private ArrayList<Tweet> tweetList = new ArrayList<Tweet>();
  int tweetLimit = 120;

  Tweet theOne;

  HashTag() {
  }

  void draw() {
    for (int i=0; i<tweetList.size (); i++) {
      Tweet tweet = tweetList.get(i);
      pushMatrix();
      if(!tweet.isPositioned()) {
       tweet.setPosition(random(displayWidth - tweet.getWidth()), random(displayHeight - tweet.getHeight())); 
      }
      translate(tweet.getXPosition(), tweet.getYPosition(),tweet.getZPosition());
      tweet.drawHash(); 
      popMatrix();
    }
  }

  public void addTweet(Status status) {
    if (status.getHashtagEntities().length != 0 && tweetList.size() < tweetLimit) {
      println("added hash");
      Tweet tweet = new Tweet(status, 3);
      tweetList.add(tweet);
      if(theOne == null) {
         theOne = tweet;
         tweet.isTheOne(); 
      }
    } else {
      //do nothing
    }
  }
}

