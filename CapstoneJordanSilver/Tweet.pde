class Tweet {


  int drawTime = 0;
  int drawLength = 6*24;

  boolean isDone = false;

  float w = 600;
  float h = 240;

  PFont font = loadFont("TwitterFont.vlw");
  PFont fontSmall = loadFont("TwitterFontSmall.vlw");

  Status status;


  //  Tweet() {
  //    status;
  //  }

  Tweet(Status statusSet) {
    status = statusSet;
  }

  void draw() {
    pushMatrix();

    float opacity;
    if (drawTime < 12) {
      opacity = map(drawTime % 24, 0, 24, 0, 255);
    } else if (drawTime > drawLength - 12) {
      opacity = map(drawTime % 24, 0, 24, 255, 0);
    } else
      opacity = 255;

    if (drawTime == 18) {
      execute();
    }


    //translate(350, 350);
    fill(47, 66, 120, opacity);
    stroke(255, opacity);
    rect(0, 0, w, h);
    fill(255, opacity);
    textFont(font);
    text(status.getText(), 15, 50);//print tweet
    textFont(fontSmall);
    text(status.getCreatedAt().toString(), 15, 225);//print date
    text("@"+status.getUser().getScreenName(), w-25-(status.getUser().getScreenName().length()*13), 225);//print username

    stroke(0);

    popMatrix();

    drawTime++;
    if (drawTime >= drawLength) {
      isDone = true;
    }
  }

  boolean isDone() {
    return isDone;
  }

  void execute() {
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
}

