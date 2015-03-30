void onSend() {
  oscP5.send(new OscMessage("/sound/on").add(1), pureData);
  println("On");
}

void offSend() {
  oscP5.send(new OscMessage("/sound/on").add(0), pureData);
  println("Off");
}

void reTwit() {
  //println("hi");
  doTwitter(); 
}

void slider(float tempo) {
  println(tempo);
}

void tempoSend() {
   oscP5.send(new OscMessage("/sound/tempo").add(debug.getTempoControl()), pureData);
   println("Sent tempo: " + debug.getTempoControl()); 
   debug.setTempo();
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
                  
    if(theEvent.getName() == "Note1") {
       println(theEvent.getStringValue()); 
       oscP5.send(new OscMessage("/sound/seq/note1").add(Integer.parseInt(theEvent.getStringValue())), pureData);
    }
    else if(theEvent.getName() == "Note2") {
       println(theEvent.getStringValue()); 
       oscP5.send(new OscMessage("/sound/seq/note2").add(Integer.parseInt(theEvent.getStringValue())), pureData);
    }
    else if(theEvent.getName() == "Note3") {
       println(theEvent.getStringValue()); 
       oscP5.send(new OscMessage("/sound/seq/note3").add(Integer.parseInt(theEvent.getStringValue())), pureData);
    }
    else if(theEvent.getName() == "Note4") {
       println(theEvent.getStringValue()); 
       oscP5.send(new OscMessage("/sound/seq/note4").add(Integer.parseInt(theEvent.getStringValue())), pureData);
    }
    else if(theEvent.getName() == "root") {
       println(theEvent.getStringValue()); 
       debug.setRoot(theEvent.getStringValue().toCharArray()[0]);
       int[] notes = debug.chord(debug.getRoot(),debug.getType());
       oscP5.send(new OscMessage("/sound/seq/note1").add(notes[0]), pureData);
       oscP5.send(new OscMessage("/sound/seq/note2").add(notes[1]), pureData);
       oscP5.send(new OscMessage("/sound/seq/note3").add(notes[2]), pureData);
    }
    else if(theEvent.getName() == "type") {
       println(theEvent.getStringValue()); 
       debug.setType(Integer.parseInt(theEvent.getStringValue()));
       int[] notes = debug.chord(debug.getRoot(),debug.getType());
       oscP5.send(new OscMessage("/sound/seq/note1").add(notes[0]), pureData);
       oscP5.send(new OscMessage("/sound/seq/note2").add(notes[1]), pureData);
       oscP5.send(new OscMessage("/sound/seq/note3").add(notes[2]), pureData);
    }
    
  }
}


