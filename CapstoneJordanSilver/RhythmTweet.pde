class RhythmTweet {

  ArrayList<TweetLane> lanes = new ArrayList<TweetLane>();

  TweetSort tweetSort = new TweetSort();
  Queue<Tweet> tweetQueue = new PriorityQueue(100, tweetSort);
  
  int laneNum = 3;

  int time;

  RhythmTweet() {
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
    moveTweets();
    //    camera(width/2.0, 0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
//    translate(width/3, 100);
    translate(0,height/2,-300);
    for (int i=0; i<lanes.size (); i++) {

      translate(width/4,0);
      
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

      println("adding tweet to lane " + lane);
      lanes.get(lane).addTweet(newTweet);

//      for (int i=0; i<lanes.size (); i++) {
//        lanes.get(i).addTweet(tweetQueue.poll());
//      }
    }
  }
}

