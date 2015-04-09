class ThisOrThat {

  ArrayList<Tweet> tweetList = new ArrayList<Tweet>();

  String word1;
  String word2;

  int count1 = 0;
  int count2 = 0;


  ThisOrThat() {
    word1 = "swag";
    word2 = "yolo";
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
    
    textFont(defaultFont);

    //line(displayWidth/2, 0, displayWidth/2, displayHeight);
    line(0, 100, displayWidth, 100);

    text(word1 + ": " + count1, displayWidth/4, 50);
    text(word2 + ": " + count2, 3*(displayWidth/4), 50);

    for (int i=0; i<tweetList.size (); i++) {
      Tweet tweet = tweetList.get(i);
      pushMatrix();
      if (!tweet.isPositioned()) {//if tweet hasn't been drawn, assign random position
        tweet.setPosition(random(displayWidth-tweet.getWidth()), 100+ random(displayHeight-tweet.getHeight() - 150));
      }
      if (tweet.contains(word1) || tweet.contains(word2)) {
        translate(tweet.getXPosition(), tweet.getYPosition());
        tweet.draw();
      }
      popMatrix();
      if (tweet.isDone()) {
        tweetList.remove(i);
        println("trying to remove");
      }
    }
    
    for (int i=0;i<tweetList.size(); i++) {
      if (tweetList.get(i).isDone()) {
        tweetList.remove(i);
      }
    }
  }
}

