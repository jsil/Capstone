import twitter4j.util.*;
import twitter4j.*;
import twitter4j.management.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.auth.*;

import java.util.Map;
import java.util.Date;

ConfigurationBuilder cb = new ConfigurationBuilder();
Twitter twitterInstance;
Query queryForTwitter;

HashMap<Character, Integer> hm = new HashMap<Character, Integer>();
HashMap<Character, Integer> letters = new HashMap<Character, Integer>();
HashMap<Character, Integer> notes = new HashMap<Character, Integer>();

//TweetDeck tweetDeck;
boolean startedTwitter;

TwitterStream twitterStream;

void startTwitter() {
  Table table = loadTable("twitterLogin.csv");
  TableRow row = table.getRow(0);

  cb.setOAuthConsumerKey(row.getString(0));
  cb.setOAuthConsumerSecret(row.getString(1));
  cb.setOAuthAccessToken(row.getString(2));
  cb.setOAuthAccessTokenSecret(row.getString(3));


  //  twitterInstance = new TwitterFactory(cb.build()
  //    ).getInstance();

//  tweetDeck = new TweetDeck();

  startedTwitter = true;
  twitterStream = new TwitterStreamFactory(cb.build()).getInstance();

  StatusListener listener = new StatusListener() {
    public void onStatus(Status status) {
      //System.out.println(status.getUser().getName() + " : " + status.getText());
      //tweetDeck.addToQueue(status);
      gm.addTweet(status);
    }
    public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
    }
    public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
    }
    public void onStallWarning(StallWarning warning) {
    }
    public void onScrubGeo(long userId, long upToStatusId) {
      System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
    }
    public void onException(Exception ex) {
      ex.printStackTrace();
    }
  };
  //TwitterStream twitterStream = new TwitterStreamFactory().getInstance();
  twitterStream.addListener(listener);

  twitterStream.addRateLimitStatusListener( new RateLimitStatusListener() {
    @Override
      public void onRateLimitStatus( RateLimitStatusEvent event ) {
      System.out.println("Limit["+event.getRateLimitStatus().getLimit() + "], Remaining[" +event.getRateLimitStatus().getRemaining()+"]");
    }

    @Override
      public void onRateLimitReached( RateLimitStatusEvent event ) {
      System.out.println("Limit["+event.getRateLimitStatus().getLimit() + "], Remaining[" +event.getRateLimitStatus().getRemaining()+"]");
    }
  } 
  );

  //EVERY WORD USED FOR EVERY GAME MUST BE LISTED HERE
  String keywords[] = {
//    "swag",
//    "yolo",
//    "#sheep",
    "sister",
    "dad",
    "uncle",
    "aunt",
    "black",
    "white",
    "wife",
    "husband",
//    "soccer",
//    "futbol",
    "bye",
    "hello",
    "want",
    "need",
    "help",
    "any",
    "change",
    "stay",
    "wait",
    "stop",
    "movie",
    "song",
    "bed",
    "bath",
    "thanks",
    "come"
//    "boss",
//    "player",
//    "police",
//    "past",
//    "future",
//    "passed",
//    "present",
//    "league",
//    "fact",
//    "lie",
//    "tweet",
//    "post",
//    "twitter",
//    "yak",
//    "finals",
//    "depression",
//    "obama",
//    "hillary",
//    "thanks",
//    "fired",
//    "hired",
//    "hump",
//    "dump"
//    "sanders"
  };
  // sample() method internally creates a thread which manipulates TwitterStream and calls these adequate listener methods continuously.
  twitterStream.filter(new FilterQuery().track(keywords));
  //twitterStream.sample();
  //twitterInstance.sample();
}

Character mode(HashMap<Character, Integer> map) {//clean up, allow multiple values to be returned
  Character highKey = ' ';
  int highVal = 0;
  for (Map.Entry entry : map.entrySet ()) {
    int num = (Integer)entry.getValue();
    //int num = 5;
    if (num > highVal) {
      highVal = num;
      //highKey.clear();
      highKey = (Character)entry.getKey();
    } 
    //    else if (entry.getValue() == highVal) {
    //      highKey.append(entry.getKey());
    //    }
  }
  return highKey;
}

Tweet currentTweet;

void drawTwitter() {
  pushMatrix();
//  tweetDeck.draw();
  popMatrix();
}

int letterToMidi(Character l) {
  if (l == 'a')
    return 69;
  else if (l == 'b')
    return 71;
  else if (l == 'c')
    return 60;
  else if (l == 'd')
    return 62;
  else if (l == 'e')
    return 64;
  else if (l == 'f')
    return 65;
  else if (l == 'g')
    return 67;
  else
    return -1;
}

void setMaps() {
  hm.put('a', 0);
  hm.put('b', 0);
  hm.put('c', 0);
  hm.put('d', 0);
  hm.put('e', 0);
  hm.put('f', 0);
  hm.put('g', 0);
  hm.put('h', 0);
  hm.put('i', 0);
  hm.put('j', 0);
  hm.put('k', 0);
  hm.put('l', 0);
  hm.put('m', 0);
  hm.put('n', 0);
  hm.put('o', 0);
  hm.put('p', 0);
  hm.put('q', 0);
  hm.put('r', 0);
  hm.put('s', 0);
  hm.put('t', 0);
  hm.put('u', 0);
  hm.put('v', 0);
  hm.put('w', 0);
  hm.put('x', 0);
  hm.put('y', 0);
  hm.put('z', 0);
  hm.put('0', 0);
  hm.put('1', 0);
  hm.put('2', 0);
  hm.put('3', 0);
  hm.put('4', 0);
  hm.put('5', 0);
  hm.put('6', 0);
  hm.put('7', 0);
  hm.put('8', 0);
  hm.put('9', 0);
  hm.put('#', 0);
  hm.put(':', 0);
  hm.put('/', 0);
  hm.put('@', 0);
  hm.put('.', 0);
  hm.put('!', 0);
  hm.put('?', 0);
  hm.put('&', 0);
  hm.put(',', 0);
  hm.put('_', 0);
  hm.put('-', 0);
  hm.put('*', 0);
  hm.put('|', 0);
  hm.put('…', 0);


  letters.put('a', 0);
  letters.put('b', 0);
  letters.put('c', 0);
  letters.put('d', 0);
  letters.put('e', 0);
  letters.put('f', 0);
  letters.put('g', 0);
  letters.put('h', 0);
  letters.put('i', 0);
  letters.put('j', 0);
  letters.put('k', 0);
  letters.put('l', 0);
  letters.put('m', 0);
  letters.put('n', 0);
  letters.put('o', 0);
  letters.put('p', 0);
  letters.put('q', 0);
  letters.put('r', 0);
  letters.put('s', 0);
  letters.put('t', 0);
  letters.put('u', 0);
  letters.put('v', 0);
  letters.put('w', 0);
  letters.put('x', 0);
  letters.put('y', 0);
  letters.put('z', 0);

  notes.put('a', 0);
  notes.put('b', 0);
  notes.put('c', 0);
  notes.put('d', 0);
  notes.put('e', 0);
  notes.put('f', 0);
  notes.put('g', 0);
}

