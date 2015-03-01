void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/sound/first")==true) {
    if(theOscMessage.checkTypetag("i")) {
      int firstValue = theOscMessage.get(0).intValue(); 
      println("/first value: "+firstValue);
      return;
    } 
  } 
  if(theOscMessage.checkAddrPattern("/sound/tempo")==true) {
    if(theOscMessage.checkTypetag("i")) {
      int firstValue = theOscMessage.get(0).intValue(); 
      println("/tempo value: "+firstValue);
      debug.setTempo(firstValue);
      return;
    } 
  } 
//  if(theOscMessage.checkAddrPattern("/phone/")==true) {
//    if(theOscMessage.checkTypetag("i")) {
//      int firstValue = theOscMessage.get(0).intValue(); 
//      println("/tempo value: "+firstValue);
//      debug.setTempo(firstValue);
//      return;
//    } 
//  } 
}
