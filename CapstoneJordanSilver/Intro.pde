class Intro {

  int time = 0;
  int maxTime = 400;

  PFont font = loadFont("GeezaPro-128.vlw");

  boolean done = false;

  Intro() {
  }

  void draw() {
    pushMatrix();
    drawScene();
    popMatrix();

    incrementTime();
  } 

  void drawScene() {
    textFont(font, 34);
    translate(width/2, height/2, 0);
    rectMode(CENTER);
    textAlign(CENTER);
    if (time < 100) {
      fill(15, 15, 255);
      rect(0, 0, width/2, height/2); 
      fill(0);
      text("This -or- That", 0, 0);
    } else if (time < 200) {
      fill(190, 210, 10);
      rect(0, 0, width/2, height/2); 
      fill(0);
      text("Move your hand to either side\nof the screen to select a word", 0, -25);
    }
    else if (time < 200) {
      fill(130, 210, 10);
      rect(0, 0, width/2, height/2); 
      fill(0);
      text("Earn points by picking the most\nfrequently tweeted word", 0, -25);
    }
    else if (time < 300) {
      fill(190, 240, 10);
      rect(0, 0, width/2, height/2); 
      fill(0);
      text("Points are awarded every 4? seconds:\n\nOverall highest points + 1\nHighest points during interval + 2\nFinal + 5", 0, -80);
    }
    else {
      fill(190, 210, 30);
      rect(0, 0, width/2, height/2); 
      fill(0);
      text("Highest points after 5 rounds wins!", 0, 0);
    }

    rectMode(CORNER);
    textAlign(LEFT);
  }

  void incrementTime() {
    time++;
    if (time >= maxTime) {
      done = true;
    }
  }

  boolean isDone() {
    return done;
  }
}

