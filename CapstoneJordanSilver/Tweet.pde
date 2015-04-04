class Tweet {

  private int drawTime = 0;
  private int drawLength = 6*24;

  private boolean isDone = false;

  private float w = 600;
  private float h = 180;
  private int lineLength = 30;

  private PFont font = loadFont("TwitterFont24.vlw");
  private PFont fontSmall = loadFont("TwitterFontSmall.vlw");

  private int position = -1;

  private Status status;


  //  Tweet() {
  //    status;
  //  }

  Tweet(Status statusSet) {
    status = statusSet;
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

    if (drawTime >= 18 && position == 0) {
      execute();
    }


    //translate(350, 350);
    fill(47, 66, 120, opacity);
    stroke(255, opacity);
    rect(0, 0, w, h);
    fill(255, opacity);
    textFont(font);

    //print tweet
    text(status.getText(), 15, 10, 570, 160); 

    textFont(fontSmall);

    text(status.getCreatedAt().toString(), w-15-textWidth(status.getCreatedAt().toString()), h-15);//print date
    text("@"+status.getUser().getScreenName(), 15, h-15);//print username

    stroke(0);
    popMatrix();

    if (drawTime >= drawLength && position == 0) {
      isDone = true;
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

