class RhythmTweet {

  ArrayList<TweetLane> lanes = new ArrayList<TweetLane>();

  TweetSort tweetSort = new TweetSort();
  Queue<Tweet> tweetQueue = new PriorityQueue(100, tweetSort);

  int time;

  RhythmTweet(int laneNum) {
    for (int i=0; i<laneNum; i++) {
      lanes.add(new TweetLane(i));
      println("creating lane " + i);
    }
  }

  void addToQueue(Status status) {
    tweetQueue.add(new Tweet(status));
  }


  void draw() {
    pushMatrix();

    //    camera(width/2.0, 0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);

    translate(400, 100);
    for (int i=0; i<lanes.size (); i++) {
      pushMatrix();

      translate(100, 0);

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

      int lane = (int)random(lanes.size());

      println("adding tweet to lane " + lane);
      lanes.get(lane).addTweet(newTweet);

      //      for (int i=0; i<lanes.size (); i++) {
      //        lanes.get(i).addTweet(tweetQueue.poll());
      //      }
    }
  }
}

