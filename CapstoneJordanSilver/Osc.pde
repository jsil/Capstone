void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/first")==true) {
    if(theOscMessage.checkTypetag("i")) {
      int firstValue = theOscMessage.get(0).intValue(); 
      println(" values: "+firstValue);
      return;
    } 
  } 
}
