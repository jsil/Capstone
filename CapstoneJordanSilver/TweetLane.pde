//to do

//this is for guitar hero-ish rhythm game

//class TweetSort implements Comparator<Tweet> {
//
//  int compare(Tweet one, Tweet two) {
//    return two.getImportance() - one.getImportance();
//  }
//}

//Queue<Tweet> tweetQueue = new PriorityQueue(100, tweetSort);
//ArrayList<Tweet> tweets = new ArrayList<Tweet>();

class TweetLane {

  
  ArrayList<Tweet> activeTweets = new ArrayList<Tweet>();


  float xPos;
  int laneNum;
  
  int angle = 45;

  TweetLane(int laneNumSet) {
    laneNum = laneNumSet;
  }

  void draw() {
    
    
    pushMatrix();
    text(laneNum,0,-100);
    rotateX(radians(-angle));
    for(int i=0;i<activeTweets.size();i++) {
        pushMatrix();
        translate(0,0,i*15);
        rotateX(radians(angle));
        activeTweets.get(i).drawSmall();
        popMatrix();
    }
    popMatrix();
  }
  
  void addTweet(Tweet newTweet) {
     activeTweets.add(newTweet);
  }
}

