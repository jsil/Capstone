void doTwitter() {
  
  Table table = loadTable("twitterLogin.csv");
  TableRow row = table.getRow(0);
   
  cb.setOAuthConsumerKey(row.getString(0));
  cb.setOAuthConsumerSecret(row.getString(1));
  cb.setOAuthAccessToken(row.getString(2));
  cb.setOAuthAccessTokenSecret(row.getString(3));

  twitterInstance = new TwitterFactory(cb.build()
    ).getInstance();
  
  List<Status> tweets;

  try {
     Query queryForTwitter = new Query("#pokemon");
     QueryResult result = twitterInstance.search(queryForTwitter);
     tweets = result.getTweets();
     Status status = tweets.get(0);
     println(status.getText());
  }
  catch (TwitterException te) {
     System.out.println("Failed to search tweets: " + te.getMessage());
     System.exit(-1);
  } 
}
