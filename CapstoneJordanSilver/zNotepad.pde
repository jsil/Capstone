//   checkbox = cp5.addCheckBox("checkBox")
//                 .setPosition(20, 35)
//                 .setColorForeground(color(120))
//                 .setColorActive(color(255))
//                 .setColorLabel(color(0))
//                 .setSize(15, 15)
//                 .setItemsPerRow(1)
//                 //.setSpacingColumn(30)
//                 .setSpacingRow(5)
//                 .addItem("Send test message to PD", 0)
//                 .addItem("50", 50)
////                 .addItem("100", 100)
////                 .addItem("150", 150)
////                 .addItem("200", 200)
////                 .addItem("255", 255)
//                 ;



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
