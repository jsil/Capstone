class Debug {

  boolean isOpen;
  float xLoc;
  float yLoc;
  float w;
  float h;
  color c;
  int tempo;
  int tempoControl;

  int time;

  controlP5.Button offBtn;
  controlP5.Button onBtn;
  controlP5.Button twitBtn;
  Textfield note1;
  Textfield note2;
  Textfield note3;
  Textfield note4;
  Slider slider;
  controlP5.Button tempoSend;

  Textfield rootText;
  Textfield typeText;
  Character root;
  int type;


  Debug() {
    isOpen = true;
    xLoc = 0;
    yLoc = 0;
    w = 250;
    h = 150;
    c = color(48, 134, 74);
    tempo = 50;
    tempoControl = 50;
    time = 0;

    root = 'c';
    type = 1;
  }

  Debug(ControlP5 cp5) {
    isOpen = true;
    xLoc = 00;
    yLoc = 00;
    w = 250;
    h = 150;
    c = color(48, 134, 74);
    tempo = 100;
    tempoControl = 100;

    time = 0;

    root = 'c';
    type = 1;

    println("C: " + (int)'c');
    //println(chord('c',1));

    onBtn = cp5.addButton("onSend");
    onBtn.setPosition(xLoc+20, yLoc+35)
      .setSize(15, 15)
        .setLabelVisible(false)
          ; 

    offBtn = cp5.addButton("offSend");
    offBtn.setPosition(xLoc+65, yLoc+35)
      .setSize(15, 15)
        .setLabelVisible(false)
          ; 

    twitBtn = cp5.addButton("reTwit");
    twitBtn.setPosition(xLoc+165, yLoc+35)
      .setSize(15, 15)
        .setLabelVisible(false)
          ; 



    offBtn.setVisible(true);
    onBtn.setVisible(true);
    twitBtn.setVisible(true);

    note1 = cp5.addTextfield("Note1")
      .setPosition(xLoc+20, yLoc+60)
        .setSize(20, 20)
          //.setFont(font)
          //.setFocus(true)
          .setColor(color(255, 0, 0))
            ;

    note2 = cp5.addTextfield("Note2")
      .setPosition(xLoc+50, yLoc+60)
        .setSize(20, 20)
          //.setFont(font)
          //.setFocus(true)
          .setColor(color(255, 0, 0))
            ;

    note3 = cp5.addTextfield("Note3")
      .setPosition(xLoc+80, yLoc+60)
        .setSize(20, 20)
          //.setFont(font)
          //.setFocus(true)
          .setColor(color(255, 0, 0))
            ;

    note4 = cp5.addTextfield("Note4")
      .setPosition(xLoc+110, yLoc+60)
        .setSize(20, 20)
          //.setFont(font)
          //.setFocus(true)
          .setColor(color(255, 0, 0))
            ;

    slider = cp5.addSlider("tempoCtrl")
      .setPosition(xLoc+20, yLoc+110)
        .setSize(150, 30)
          .setRange(50, 400)
            //.setNumberOfTickMarks(200)
            //.setLabelVisible(false)
            .setSliderMode(Slider.FLEXIBLE)
              .plugTo(this, "tempoControl")
                ;

    tempoSend = cp5.addButton("tempoSend")
      .setPosition(xLoc+173, yLoc+118)
        .setSize(53, 15)
          //.setLabelVisible(false)
          ; 

    rootText = cp5.addTextfield("root")
      .setPosition(xLoc+150, yLoc+60)
        .setSize(20, 20)
          //.setFont(font)
          //.setFocus(true)
          .setColor(color(255, 0, 0))
            ;

    typeText = cp5.addTextfield("type")
      .setPosition(xLoc+175, yLoc+60)
        .setSize(20, 20)
          //.setFont(font)
          //.setFocus(true)
          .setColor(color(255, 0, 0))
            ;
  }

  void draw() {
    pushMatrix();
    translate(xLoc, yLoc, 0);
    if (isOpen) {
      fill(c);
      rect(0, 0, w, h);
      fill(0);
      text("Debug Console", 5, 15);
      noFill();
      rect(w-15, 0, 15, 15);
      line(w-15, 0, w, 15);
      line(w, 0, w-15, 15);

      text("On", 40, 47);
      text("Off", 85, 47);
      text("Time: " + time, 110, 47);
      text("ReTwit", 185, 47);
    } else {
      fill(c);
      rect(0, 0, 20, 20);
      fill(0);
      text("D", 5, 15);
    }
    popMatrix();
  }

  void click(float x, float y) {
    if (isOpen) {
      if (isClicked(x, y)) {
        if ((xLoc+w-15 <= x && x <= xLoc+w) && (yLoc <= y && y <= yLoc+18)) {//if 'X' is clicked
          hide();
        }

        //          if(xLoc+20 <= x && x <= xLoc+35) {
        //              if(yLoc+35 <= y && y <= yLoc+58) {//Send test message to Pure Data
        //                 oscP5.send(new OscMessage("/seq/note4").add(25), pureData);
        //                 println("Sent"); 
        //              } 
        //          }
      }
    } else {
      if (isClicked(x, y)) {
        show();
      }
    }
  }

  void hide() {
    isOpen = false;
    offBtn.setVisible(false);
    onBtn.setVisible(false);
    twitBtn.setVisible(false);

    note1.setVisible(false);
    note2.setVisible(false);
    note3.setVisible(false);
    note4.setVisible(false);
    slider.setVisible(false);
    tempoSend.setVisible(false);

    rootText.setVisible(false);
    typeText.setVisible(false);
    //println("Closed Console");
  }

  void show() {
    isOpen = true;
    offBtn.setVisible(true);
    twitBtn.setVisible(true);

    onBtn.setVisible(true);
    note1.setVisible(true);
    note2.setVisible(true);
    note3.setVisible(true);
    note4.setVisible(true);
    slider.setVisible(true);
    tempoSend.setVisible(true);

    rootText.setVisible(true);
    typeText.setVisible(true);
    //println("Opened Console");
  }

  boolean isClicked(float x, float y) {
    if (isOpen) {
      if ((xLoc <= x && x <= (xLoc+w)) && (yLoc <= y && y <= (yLoc+h))) {
        //println("Clicked! " + x + " " + y); 
        return true;
      } else
        return false;
    } else {
      if ((xLoc <= x && x <= (xLoc+20)) && (yLoc <= y && y <= (yLoc+20))) {
        return true;
      } else
        return false;
    }
  }

  float getTempo() {
    return tempo;
  }

  float getTempoControl() {
    return tempoControl;
  }

  void setTempo() {
    tempo = tempoControl;
  }

  void setTempo(int tempoSet) {
    if (tempo != tempoSet) {
      tempo = tempoSet;
      tempoControl = tempoSet;
      slider.setValue(tempo);
    }
  }

  void setTime(int timeSet) {
    time = timeSet;
  }

  void sendNote(int noteNum, int val) {
    String note;
    if (noteNum == 1)
      note = "note1";
    else if (noteNum == 2)
      note = "note2"; 
    else if (noteNum == 3)
      note = "note3"; 
    else if (noteNum == 4)
      note = "note4"; 
    else {
      return;
    }

    oscP5.send(new OscMessage("/sound/seq/" + note).add(val), pureData);
  }

  int[] chord(Character root, int type) {
    //type: 1=major, 2=minor, 3=augmented triad, 4=diminished triad
    int rootMidi = 0;
    if (root == 'a')
      rootMidi = 69; 
    else if (root == 'b')
      rootMidi = 71; 
    else if (root == 'c')
      rootMidi = 60; 
    else if (root == 'd')
      rootMidi = 62; 
    else if (root == 'e')
      rootMidi = 64; 
    else if (root == 'f')
      rootMidi = 65; 
    else if (root == 'g')
      rootMidi = 67; 
    else {
      return new int[] {
        0, 0, 0
      };
    }

    if (type==1) {
      return new int[] {
        rootMidi, rootMidi+4, rootMidi+7
      };
    } else if (type==2) {
      return new int[] {
        rootMidi, rootMidi+3, rootMidi+7
      };
    } else if (type==3) {
      return new int[] {
        rootMidi, rootMidi+4, rootMidi+8
      };
    } else if (type==4) {
      return new int[] {
        rootMidi, rootMidi+3, rootMidi+6
      };
    } else
      return new int[] {
      0, 0, 0
    };
  }

  Character getRoot() {
    return root;
  }

  void setRoot(Character rootSet) {
    root = rootSet;
  }

  int getType() {
    return type;
  }

  void setType(int typeSet) {
    type = typeSet;
  }
}

