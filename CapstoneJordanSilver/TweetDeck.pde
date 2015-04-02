import java.util.PriorityQueue;

class TweetDeck {

  Queue<Tweet> tweetQueue = new PriorityQueue(15);
  ArrayList<Tweet> currentTweets = new ArrayList<Tweet>();


  TweetDeck() {
  }

  void addToQueue(Status status) {
    tweetQueue.add(new Tweet(status));
  }

  void draw() {

    while(currentTweets.size() < 5) {
      Tweet newTweet = tweetQueue.poll();
      if(newTweet == null) break;
      currentTweets.add(newTweet);
    }

    int numTweets = currentTweets.size();
    //println("numTweets: " + numTweets);
    for (int i=0; i<currentTweets.size (); i++) {
      pushMatrix();
      translate(width-600, 240*i);
      //println("i: " + i);
      currentTweets.get(i).draw();
      popMatrix();
    }
//
    for (int j=numTweets-1; j>=0; j--) {
      if (currentTweets.get(j).isDone()) {
        currentTweets.remove(j);
        println("removed tweet");
      }
    }
  }
}

