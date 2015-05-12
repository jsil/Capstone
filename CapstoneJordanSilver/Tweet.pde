class Tweet {

  private int drawTime = 0;
  private int drawLength = 3*24;

  private boolean isDone = false;
  private boolean hasExecuted = false;

  private PFont font = loadFont("TwitterFont16.vlw");
  private PFont fontSmall = loadFont("TwitterFont12.vlw");

  private float w = 350;
  private float h;

  float w2 = 100;
  float h2 = 100;

  private int lineLength = 30;

  //non-negative when tweet is in a queue
  //execute() and other timing-based code will only execute when position == 0 OR 1
  private int position = -1;

  //used when tweet is drawn to an area
  private boolean isPositioned = false;
  private float xPos;
  private float yPos;

  color bgColor;

  private Status status;

  private int bgMode = 0;

  PImage img;

  boolean goodOrBad;

  float zPosition = 0;
  float zMod = 10;
  float zMax = 800;

  String hashtag;
  boolean theOne = false;

  float xVel = 0;
  float yVel = 0;

  Tweet(Status statusSet, int mode) {
    status = statusSet;
    if (mode == 1) {
      textFont(font);
      h = (textAscent() + textDescent()) * 6 + 50;
    }
    if (mode == 2) {
      getPicture();

      if ((int)random(3) == 1) {
        goodOrBad = false;
      } else {
        goodOrBad = true;
      }
    }
    if (mode == 3) {
      zPosition = random(12);
      HashtagEntity[] tags = status.getHashtagEntities();
      if (tags.length != 0 && tags[0].getText().indexOf(' ') != 1) {
        hashtag = "#" + tags[0].getText();
      } else {
        println("no tag broken");
      }
      w = 50 + textWidth(hashtag);
      h = 30;
      xVel = 20 - random(40);
      yVel = 20 - random(40);
      drawLength = 8*24;
    }
  }

  boolean isGood() {
    return goodOrBad;
  }

  void pushRandom() {
    xVel += 20 - random(40);
    yVel += 20 - random(40);
  }

  void pushX(boolean direction) {
     if(direction) {
        xVel += 15;
     } 
     else {
       xVel -= 15;
     }
  }

  void pushY(boolean direction) {
     if(direction) {
        yVel += 15;
     } 
     else {
       yVel -= 15;
     }
  }

  float getXVel() {
    return xVel;
  }

  float getYVel() {
    return yVel;
  }

  void incrementXVel() {
    if (xVel > 0) {
      if (xVel > 1) {
        xVel--;
      } else {
        xVel = xVel/2 - 1;
        if (xVel <= 0) {
          xVel = 0;
        }
      }
    } else if (xVel < 0) {
      if (xVel < -1) {
        xVel++;
      } else {
        xVel = xVel/2 + 1;
        if (xVel >= 0) {
          xVel = 0;
        }
      }
    }
  }

  void incrementYVel() {
    if (yVel > 0) {
      if (yVel > 1) {
        yVel--;
      } else {
        yVel = yVel/2 - 1;
        if (yVel <= 0) {
          yVel = 0;
        }
      }
    } else if (yVel < 0) {
      if (yVel < -1) {
        yVel++;
      } else {
        yVel = yVel/2 + 1;
        if (yVel >= 0) {
          yVel = 0;
        }
      }
    }
  }

  void moveVelocity() {
    if (xPos > 0 && xPos < width-w) {
      xPos += xVel; 
      incrementXVel();
    } else {
      xVel = -xVel;
      xPos += xVel; 
      incrementXVel();
    }
    if (yPos > 0 && yPos < height-h-50) {
      yPos += yVel; 
      incrementYVel();
    } else {
      yVel = -yVel;
      yPos += yVel; 
      incrementYVel();
    }
  }

  void theOne() {
    theOne = true;
  }

  boolean isTheOne() {
    return theOne;
  }

  void drawHash() {
    textFont(defaultFont);
    float wid = 50 + textWidth(hashtag);
    pushMatrix();
    noStroke();
    if (!theOne) {
      fill(150, 240, 235);
      translate(0, 0, zPosition);
    } else {
      fill(255, 0, 0);
      translate(0, 0, 13);
    }  
    rect(0, 0, wid, 30);
    fill(0);
    textAlign(CENTER);
    text(hashtag, wid/2, 20);
    textAlign(LEFT);
    moveVelocity();
    popMatrix();
    drawTime++;
    if (drawTime >= drawLength && !theOne) {
      isDone = true;
    }
  }

  void getPicture() {
    User user = status.getUser(); 
    String url = user.getProfileImageURL();
    img = loadImage(url, "jpg");
    //    println("url: " + url);
  }

  public void draw() {
    pushMatrix();

    float opacity;
    if (drawTime < 12) {
      //      opacity = map(drawTime % 24, 0, 24, 0, 255);
      drawTime++;
    } else if (drawTime > drawLength - 12 && (position <= 0)) {
      float rand = random(100);
      //      if (rand >= 80) {
      //        if(rand >= 95) {
      //          sampleSend(4);
      //        }
      //        else {
      //          sampleSend(3); 
      //        }
      //      }
      opacity = map(drawTime % 24, 0, 24, 255, 0);
      drawTime++;
    } else {
      opacity = 255;
      if (position <= 0)
        drawTime++;
    }

    if (drawTime >= 18 && position <= 0 && !hasExecuted) {
      execute();
    }

    //translate(350, 350);
    //    drawBG(opacity);
    drawBG();
    //fill(47, 66, 120, opacity);
    //stroke(255, opacity);
    //rect(0, 0, w, h);

    textFont(font);

    //print tweet
    text(status.getText(), 15, 10, w-30, h-20); 

    textFont(fontSmall);

    text(status.getCreatedAt().toString(), w-15-textWidth(status.getCreatedAt().toString()), h-15);//print date
    text("@"+status.getUser().getScreenName(), 15, h-15);//print username

    stroke(0);
    popMatrix();

    if (drawTime >= drawLength && position <= 0) {
      isDone = true;
    }
  }


  public void drawSmall() {
    pushMatrix();

    if (drawTime >= 18 && position <= 0 && !hasExecuted) {
      execute();
    }

    rectMode(CENTER);
    imageMode(CENTER);

    stroke(255);
    if (goodOrBad) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    rect(0, 0, w2+20, h2+20);
    image(img, 0, 0, w2, h2);

    stroke(0);

    rectMode(CORNER);
    imageMode(CORNER);

    popMatrix();

    zPosition += zMod;

    if (zPosition >= zMax) {
      isDone = true;
    }
  }

  private void drawBG() {
    if (bgMode == 0) {
      fill(bgColor);
      stroke(255);
      rect(0, 0, w, h);
      fill(255);
    } else if (bgMode == 1) {
      fill(238, 77, 73);
      stroke(255);
      rect(0, 0, w, h);
      fill(255);
    } else if (bgMode == 2) {
      fill(255);
      stroke(0);
      rect(0, 0, w, h);
      fill(0);
    }
  }

  private void drawBG(float opacity) {
    if (bgMode == 0) {
      fill(bgColor);
      stroke(255);
      rect(0, 0, w, h);
      fill(255, opacity);
    } else if (bgMode == 1) {
      fill(238, 77, 73);
      stroke(255);
      rect(0, 0, w, h);
      fill(255, opacity);
    } else if (bgMode == 2) {
      fill(255);
      stroke(0);
      rect(0, 0, w, h);
      fill(0, opacity);
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
      bgMode = 1;
      sampleSend(1);
      postTweet();
    }
    if (message.indexOf("#sheep") != -1) {
      bgMode = 2;
      sampleSend(2);
    }
    hasExecuted = true;
  }

  PImage getImage() {
    return img;
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
    } else if (message.indexOf("#sheep") != -1 ) {
      return true;
    } else
      return false;
  }

  boolean contains(String substring) {
    String message = status.getText();
    if (message.indexOf(substring) != -1) {
      return true;
    } else {
      return false;
    }
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

  void setPosition(float x, float y) {
    xPos = x;
    yPos = y;
    isPositioned = true;
  }

  float getXPosition() {
    return xPos;
  }

  float getYPosition() {
    return yPos;
  }

  float getZPosition() {
    return zPosition;
  }

  boolean isPositioned() {
    return isPositioned;
  }

  void setColor(color col) {
    bgColor = col;
  }

  //to do: figure out how to post a tweet despite using tweetStream
  void postTweet() {
    //    Twitter twitter = TwitterFactory.getSingleton();
    //    try {
    //      Status status2 = twitter.updateStatus("test post plz ignore");
    //      println("posted " + status2.getText());
    //    }
    //    catch (TwitterException e) {
    //      // TODO Auto-generated catch block
    //      e.printStackTrace();
    //    }
    //
    //
  }
}

