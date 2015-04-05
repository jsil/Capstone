import java.util.Map;
import java.util.Date;

HashMap<Character, Integer> hm = new HashMap<Character, Integer>();
HashMap<Character, Integer> letters = new HashMap<Character, Integer>();
HashMap<Character, Integer> notes = new HashMap<Character, Integer>();

TweetDeck tweetDeck;

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

  tweetDeck = new TweetDeck();

  startedTwitter = true;

  twitterStream = new TwitterStreamFactory(cb.build()).getInstance();


  StatusListener listener = new StatusListener() {
    public void onStatus(Status status) {
      System.out.println(status.getUser().getName() + " : " + status.getText());
      tweetDeck.addToQueue(status);
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

  String keywords[] = {
    "swag",
    "yolo"
  };
  // sample() method internally creates a thread which manipulates TwitterStream and calls these adequate listener methods continuously.
  twitterStream.filter(new FilterQuery().track(keywords));
  //twitterStream.sample();
  //twitterInstance.sample();
}

void doTwitter() {

//  if (startedTwitter) {
//    List<Status> tweets;
//
//    setMaps();
//
//    try {
//      Query queryForTwitter = new Query("#twitbotdance");
//      QueryResult result = twitterInstance.search(queryForTwitter);
//      tweets = result.getTweets();
//
//      int delayCount = 0;
//
//      for (int j=0; j<tweets.size (); j++) {
//
//        //        if (j%4 == 0)
//        //          delayCount = drawCount;
//
//        Status status = tweets.get(j);
//        //println(status.getText());
//
//        tweetDeck.addToQueue(status);
//        //        println("added tweet");
//
//
//        Date tweetDate = status.getCreatedAt();
//        println(tweetDate);
//
//        String message = status.getText().toLowerCase();
//        println("\"" + status.getText().toLowerCase() + "\"");
//
//
//
//        //String message = "abcdefghijklmnopqrstuvwxyz         $%^&*(*&^%$#@ EEEEEE";
//
//        for (int i=0; i<message.length (); i++) { //weirdness is happening counting "e's, o's", etc.
//
//          if (hm.get(message.charAt(i)) != null) {
//            hm.put(message.charAt(i), hm.get(message.charAt(i))+1);
//            if (Character.isLetter(message.charAt(i))) {
//              letters.put(message.charAt(i), letters.get(message.charAt(i))+1);
//            }
//            if (((int)message.charAt(i) >= 97) && ((int)message.charAt(i) <= 103)) {
//              notes.put(message.charAt(i), notes.get(message.charAt(i))+1);
//              //to do: stuff
//              //println(message.charAt(i));
//            }
//          }
//        }
//        //    for (Map.Entry me : hm.entrySet ()) {
//        //      print(me.getKey() + ": ");
//        //      println(me.getValue());
//        //    }
//        //    
//        //    
//        //    println("\n\n\n");
//        //    
//        //    for (Map.Entry me : letters.entrySet ()) {
//        //      print(me.getKey() + ": ");
//        //      println(me.getValue());
//        //    }
//
//        //      for (Map.Entry me : notes.entrySet ()) {
//        //        print(me.getKey() + ": ");
//        //        println(me.getValue());
//        //      }
//
//        //      println((mode(notes)));
//        //      
//        //      debug.sendNote(j%4, letterToMidi(mode(notes)));
//        //      
//        //      setMaps();
//
//        if (j%4 == 3) {
//          //         while(drawCount <= delayCount + 9000)
//          //            draw();
//          println("delay over");
//        }
//      }
//
//      //println(hm.get("e"));
//      //println("Mode: " + mode(letters));
//    }
//    catch (TwitterException te) {
//      System.out.println("Failed to search tweets: " + te.getMessage());
//      System.exit(-1);
//    }
//  }
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

  tweetDeck.draw();


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

