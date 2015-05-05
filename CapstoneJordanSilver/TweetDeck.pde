import java.util.PriorityQueue;
import java.util.Comparator;

//Custom Comparator for PriorityQueue w/ Tweet class
class TweetSort implements Comparator<Tweet> {

  int compare(Tweet one, Tweet two) {
    return two.getImportance() - one.getImportance();
  }
}

class TweetDeck {

  TweetSort tweetSort = new TweetSort();
  Queue<Tweet> tweetQueue = new PriorityQueue(100, tweetSort);
  
  ArrayList<Tweet> currentTweets = new ArrayList<Tweet>();

  TweetDeck() {
  }

  void addToQueue(Status status) {
    tweetQueue.add(new Tweet(status));
  }

  void draw() {
    while (currentTweets.size () < 5) {
      Tweet newTweet = tweetQueue.poll();
      if (newTweet == null) break;
      currentTweets.add(newTweet);
    }

    int numTweets = currentTweets.size();
    //println("numTweets: " + numTweets);
    for (int i=0; i<currentTweets.size (); i++) {
      pushMatrix();
      translate(width-currentTweets.get(i).getWidth(), currentTweets.get(i).getHeight()*i);
      //println("i: " + i);
      currentTweets.get(i).setPosition(i);
      currentTweets.get(i).draw();
      popMatrix();
    }
    //check if Tweet is done & remove it
    for (int j=numTweets-1; j>=0; j--) {
      if (currentTweets.get(j).isDone()) {
        currentTweets.remove(j);
      }
    }
  }
}

