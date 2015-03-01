class Debug {
  
  boolean isOpen;
  float xLoc;
  float yLoc;
  float w;
  float h;
  color c;
  int tempo;
  int tempoControl;
  
  Button offBtn;
  Button onBtn;
  Textfield note1;
  Textfield note2;
  Textfield note3;
  Textfield note4;
  Slider slider;
  Button tempoSend;
  
  
   Debug() {
    isOpen = true;
    xLoc = 0;
    yLoc = 0;
    w = 250;
    h = 150;
    c = color(48,134,74);
    tempo = 50;
    tempoControl = 50;
   }
  
  Debug(ControlP5 cp5) {
    isOpen = true;
    xLoc = 00;
    yLoc = 00;
    w = 250;
    h = 150;
    c = color(48,134,74);
    tempo = 100;
    tempoControl = 100;
    
    onBtn = cp5.addButton("onSend");
    onBtn.setPosition(xLoc+20,yLoc+35)
     .setSize(15,15)
     .setLabelVisible(false)
     ; 
     
    offBtn = cp5.addButton("offSend");
    offBtn.setPosition(xLoc+65,yLoc+35)
     .setSize(15,15)
     .setLabelVisible(false)
     ; 
     
     offBtn.setVisible(true);
     onBtn.setVisible(true);
     
    note1 = cp5.addTextfield("Note1")
     .setPosition(xLoc+20,yLoc+60)
     .setSize(20,20)
     //.setFont(font)
     //.setFocus(true)
     .setColor(color(255,0,0))
     ;
     
    note2 = cp5.addTextfield("Note2")
     .setPosition(xLoc+50,yLoc+60)
     .setSize(20,20)
     //.setFont(font)
     //.setFocus(true)
     .setColor(color(255,0,0))
     ;
     
    note3 = cp5.addTextfield("Note3")
     .setPosition(xLoc+80,yLoc+60)
     .setSize(20,20)
     //.setFont(font)
     //.setFocus(true)
     .setColor(color(255,0,0))
     ;
     
    note4 = cp5.addTextfield("Note4")
     .setPosition(xLoc+110,yLoc+60)
     .setSize(20,20)
     //.setFont(font)
     //.setFocus(true)
     .setColor(color(255,0,0))
     ;
     
    slider = cp5.addSlider("tempoCtrl")
     .setPosition(xLoc+20,yLoc+110)
     .setSize(150,30)
     .setRange(50,400)
     //.setNumberOfTickMarks(200)
     //.setLabelVisible(false)
     .setSliderMode(Slider.FLEXIBLE)
     .plugTo(this, "tempoControl")
     ;
     
    tempoSend = cp5.addButton("tempoSend")
     .setPosition(xLoc+173,yLoc+118)
     .setSize(53,15)
     //.setLabelVisible(false)
     ; 

     
  }
  
  void draw() {
    pushMatrix();
    translate(xLoc,yLoc,0);
    if(isOpen) {
        fill(c);
        rect(0,0,w,h);
        fill(0);
        text("Debug Console",5,15);
        noFill();
        rect(w-15,0, 15, 15);
        line(w-15,0, w, 15);
        line(w, 0, w-15, 15);
        
        text("On", 40,47);
        text("Off", 85,47);
    }
    else {
      fill(c);
      rect(0,0,20,20);
      fill(0);
      text("D",5,15); 
    }
    popMatrix();
  }
  
  void click(float x, float y) {
    if(isOpen) {
      if(isClicked(x,y)) {
          if((xLoc+w-15 <= x && x <= xLoc+w) && (yLoc <= y && y <= yLoc+18)) {//if 'X' is clicked
              hide();
          }
          
//          if(xLoc+20 <= x && x <= xLoc+35) {
//              if(yLoc+35 <= y && y <= yLoc+58) {//Send test message to Pure Data
//                 oscP5.send(new OscMessage("/seq/note4").add(25), pureData);
//                 println("Sent"); 
//              } 
//          }
      }
    }
    else {
       if(isClicked(x,y)) {
          show();
       } 
    }
  }
  
  void hide() {
    isOpen = false;
    offBtn.setVisible(false);
    onBtn.setVisible(false);
    note1.setVisible(false);
    note2.setVisible(false);
    note3.setVisible(false);
    note4.setVisible(false);
    slider.setVisible(false);
    tempoSend.setVisible(false);
    //println("Closed Console");
  }
  
  void show() {
    isOpen = true;
    offBtn.setVisible(true);
    onBtn.setVisible(true);
    note1.setVisible(true);
    note2.setVisible(true);
    note3.setVisible(true);
    note4.setVisible(true);
    slider.setVisible(true);
    tempoSend.setVisible(true);
    //println("Opened Console");
  }
  
  boolean isClicked(float x, float y) {
    if(isOpen) {
       if((xLoc <= x && x <= (xLoc+w)) && (yLoc <= y && y <= (yLoc+h))) {
          //println("Clicked! " + x + " " + y); 
          return true;
       }
       else
          return false;
    }
    else {
       if((xLoc <= x && x <= (xLoc+20)) && (yLoc <= y && y <= (yLoc+20))) {
          return true; 
       }
       else
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
    if(tempo != tempoSet) {
      tempo = tempoSet;
      tempoControl = tempoSet;
      slider.setValue(tempo);
    }
  }
}
