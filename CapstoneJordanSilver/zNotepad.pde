



//public static void main(String[] args) throws TwitterException, IOException{
//    StatusListener listener = new StatusListener(){
//        public void onStatus(Status status) {
//            System.out.println(status.getUser().getName() + " : " + status.getText());
//        }
//        public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {}
//        public void onTrackLimitationNotice(int numberOfLimitedStatuses) {}
//        public void onException(Exception ex) {
//            ex.printStackTrace();
//        }
//    };
//    TwitterStream twitterStream = new TwitterStreamFactory().getInstance();
//    twitterStream.addListener(listener);
//    // sample() method internally creates a thread which manipulates TwitterStream and calls these adequate listener methods continuously.
//    twitterStream.sample();
//}
