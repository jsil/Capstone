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
    tweetQueue.add(new Tweet(status, 2));
  }


  void draw() {
    //    println("trying to draw rhythm");
    pushMatrix();
    moveTweets();
    int laneSelection = -1;
    if (hands.getFirstHand() != null) {
      laneSelection = hands.getTrinarySelection(hands.getFirstHand().getHandId());
      println("lane selection: " + laneSelection);
    } else {
      println("hand lost");
    }
    
    pushMatrix();
    translate(width/4, height/2-15, 0);
    
    strokeWeight(2);
    if(laneSelection != -1) {
       stroke(160);
       if(laneSelection == 1) {
         stroke(255,0,0);
       }
       line(0,0,width*.25,0);
       
       stroke(160);
       if(laneSelection == 2) {
         stroke(0,255,0);
       }
       line(width/4,10,width/2,10);
       
       stroke(160);
       if(laneSelection == 3) {
         stroke(255,255,255);
       }
       line(width*.75,20,width,20);
    }
    else {
       stroke(80);
//       line(0,0,width/4,0);
//       line(width/4,10,width/2,10);
//       line(width*.75,20,width,20);
    }
    popMatrix();
    
    translate(0, height*.4, -300);

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

      println("adding tweet to lane " + lane);
      lanes.get(lane).addTweet(newTweet);

      //      for (int i=0; i<lanes.size (); i++) {
      //        lanes.get(i).addTweet(tweetQueue.poll());
      //      }
    }
  }
}

