void testSend() {
   //println("TODO:send test data");
   oscP5.send(new OscMessage("/test").add(1), pureData);
   println("Sent test signal."); 
}

void slider(float tempo) {
  println(tempo);
}

void tempoSend() {
   oscP5.send(new OscMessage("/tempo").add(debug.getTempo()), pureData);
   println("Sent tempo:" + debug.getTempo()); 
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
            
            
    if(theEvent.getName() == "Note1") {
       println(theEvent.getStringValue()); 
       oscP5.send(new OscMessage("/seq/note1").add(Integer.parseInt(theEvent.getStringValue())), pureData);
    }
    else if(theEvent.getName() == "Note2") {
       println(theEvent.getStringValue()); 
       oscP5.send(new OscMessage("/seq/note2").add(Integer.parseInt(theEvent.getStringValue())), pureData);
    }
    else if(theEvent.getName() == "Note3") {
       println(theEvent.getStringValue()); 
       oscP5.send(new OscMessage("/seq/note3").add(Integer.parseInt(theEvent.getStringValue())), pureData);
    }
    else if(theEvent.getName() == "Note4") {
       println(theEvent.getStringValue()); 
       oscP5.send(new OscMessage("/seq/note4").add(Integer.parseInt(theEvent.getStringValue())), pureData);
    }
  }
}


