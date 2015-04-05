class Tweet {

  private int drawTime = 0;
  private int drawLength = 2*24;

  private boolean isDone = false;
  private boolean hasExecuted = false;

  private PFont font = loadFont("TwitterFont16.vlw");
  private PFont fontSmall = loadFont("TwitterFont12.vlw");

  private float w = 350;
  private float h;
  private int lineLength = 30;

  private int position = -1;

  private Status status;

  private int bgMode = 0;


  //  Tweet() {
  //    status;
  //  }

  Tweet(Status statusSet) {
    status = statusSet;
    
    textFont(font);
    h = (textAscent() + textDescent()) * 6 + 50;
  }


  public void draw() {
    pushMatrix();

    float opacity;
    if (drawTime < 12) {
      opacity = map(drawTime % 24, 0, 24, 0, 255);
      drawTime++;
    } else if (drawTime > drawLength - 12 && position == 0) {
      opacity = map(drawTime % 24, 0, 24, 255, 0);
      drawTime++;
    } else {
      opacity = 255;
      if (position == 0)
        drawTime++;
    }

    if (drawTime >= 18 && position == 0 && !hasExecuted) {
      execute();
    }


    //translate(350, 350);
    drawBG(opacity);
    //fill(47, 66, 120, opacity);
    //stroke(255, opacity);
    //rect(0, 0, w, h);
    fill(255, opacity);
    textFont(font);

    //print tweet
    text(status.getText(), 15, 10, w-30, h-20); 

    textFont(fontSmall);

    text(status.getCreatedAt().toString(), w-15-textWidth(status.getCreatedAt().toString()), h-15);//print date
    text("@"+status.getUser().getScreenName(), 15, h-15);//print username

    stroke(0);
    popMatrix();

    if (drawTime >= drawLength && position == 0) {
      isDone = true;
    }
  }

  private void drawBG() {
    if (bgMode == 0) {
      fill(47, 66, 120);
      stroke(255);
      rect(0, 0, w, h);
    } else if (bgMode == 1) {
      fill(238, 77, 73);
      stroke(255);
      rect(0, 0, w, h);
    }
  }

  private void drawBG(float opacity) {
    if (bgMode == 0) {
      fill(47, 66, 120, opacity);
      stroke(255, opacity);
      rect(0, 0, w, h);
    } else if (bgMode == 1) {
      fill(238, 77, 73, opacity);
      stroke(255, opacity);
      rect(0, 0, w, h);
    }
  }

  public boolean isDone() {
    return isDone;
  }

  private void execute() {
    String message = status.getText();
    if (message.indexOf("tempo") != -1) {
      //println("tempo command"); 
      if (message.indexOf("up") != -1) {
        //raise tempo 
        println("tempo up");
        debug.setTempo((int)debug.getTempo()+2);
      } else if (message.indexOf("down") != -1) {
        //lower tempo 
        println("tempo down");
        debug.setTempo((int)debug.getTempo()-2);
      }
    }
    if (message.indexOf("swag") != -1 && message.indexOf("yolo") != -1) {
      //println("#YOLO #SWAG!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      bgMode = 1;
    }
    hasExecuted = true;
  }

  public int getImportance() {
    if (this.isCommand())
      return 1; 
    else
      return 0;
  }

  boolean isCommand() {
    String message = status.getText();
    if (message.indexOf("tempo") != -1) {
      return true;
    } else if (message.indexOf("swag") != -1 && message.indexOf("yolo") != -1) {
      return true;
    } else
      return false;
  }

  void setPosition(int positionSet) {
    position = positionSet;
  }

  int getPosition() {
    return position;
  }

  float getWidth() {
    return w;
  }

  float getHeight() {
    return h;
  }
}

