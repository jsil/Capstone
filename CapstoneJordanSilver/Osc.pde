void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/first")==true) {
    if(theOscMessage.checkTypetag("i")) {
      int firstValue = theOscMessage.get(0).intValue(); 
      println("/first value: "+firstValue);
      return;
    } 
  } 
  if(theOscMessage.checkAddrPattern("/tempo")==true) {
    if(theOscMessage.checkTypetag("i")) {
      int firstValue = theOscMessage.get(0).intValue(); 
      println("/tempo value: "+firstValue);
      debug.setTempo(firstValue);
      return;
    } 
  } 
}
