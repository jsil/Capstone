class Intro {

  int time = 0;
  int maxTime = 400;

  PFont font = loadFont("GeezaPro-128.vlw");

  boolean done = false;

  int mode;

  PImage img1, img2, img3, img4;


  Intro(int mode_) {
    mode = mode_;
    if (mode == 2) {
      loadImages();
    }
    else if(mode == 3) {
      loadImages();
      maxTime = 300; 
    }
  }

  void draw() {
    pushMatrix();
    if (mode == 1) {
      drawScene1();
    } else if (mode == 2) {
      drawScene2();
    } else if (mode == 3) {
      drawScene3();
    }
    popMatrix();

    incrementTime();
  } 

  void loadImages() {
    if (mode == 2) {
      img1 = loadImage("intros/2/3.png"); 
      img2 = loadImage("intros/2/0.png"); 
      img3 = loadImage("intros/2/2.png"); 
      img4 = loadImage("intros/2/1.png");
    } else if (mode == 3) {
      img1 = loadImage("intros/3/1.png"); 
      img2 = loadImage("intros/3/2.png"); 
      img3 = loadImage("intros/3/3.png");
    }
  }

  void drawScene1() {
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
    } else if (time < 200) {
      fill(130, 210, 10);
      rect(0, 0, width/2, height/2); 
      fill(0);
      text("Earn points by picking the most\nfrequently tweeted word", 0, -25);
    } else if (time < 300) {
      fill(190, 240, 10);
      rect(0, 0, width/2, height/2); 
      fill(0);
      text("Points are awarded every 4? seconds:\n\nOverall highest points + 1\nHighest points during interval + 2\nFinal + 5", 0, -80);
    } else {
      fill(190, 210, 30);
      rect(0, 0, width/2, height/2); 
      fill(0);
      text("Highest points after 5 rounds wins!", 0, 0);
    }

    rectMode(CORNER);
    textAlign(LEFT);
  }


  void drawScene2() {
    textFont(font, 34);
    textAlign(CENTER);
    if (time < 100) {
      image(img1, 0, 0, width, height);
      fill(50, 190);
      rect(0, height/4, width, height/4);
      fill(255);
      text("Tweet Beat\n\nBuild a mosaic of profile pics by hitting the green notes!", width/2, height/3);
    } else if (time < 200) {
      image(img2, 0, 0, width, height);
      fill(50, 190);
      rect(0, height/4, width, height/4);
      fill(255);
      text("Green notes add to the mosaic & your points.\n\nRed notes remove pictures from the mosaic & reduce your points.", width/2, height/3);
    } else if (time < 300) {
      image(img3, 0, 0, width, height);
      fill(50, 190);
      rect(0, height/4, width, height/4);
      fill(255);
      text("Select your lane by moving your hand over it!", width/2, height/3);
    } else if (time < 400) {
      image(img4, 0, 0, width, height);
      fill(50, 190);
      rect(0, height/4, width, height/4);
      fill(255);
      text("Screenshots are taken periodically & can be found in the 'screenshots' folder!", width/2, height/3);
    }

    rectMode(CORNER);
    textAlign(LEFT);
  }

  void drawScene3() {
    textFont(font, 34);
    textAlign(CENTER);
    if (time < 100) {
      image(img1, 0, 0, width, height);
      fill(50, 190);
      rect(0, height/4, width, height/4);
      fill(255);
      text("Hash Tag\n\nWork together to find the correct hash tags and score points!", width/2, height/3);
    } else if (time < 200) {
      image(img2, 0, 0, width, height);
      fill(50, 190);
      rect(0, height/4, width, height/4);
      fill(255);
      text("All of the #hashtags respond to your hands,\nbut only one gives you points!", width/2, height/3);
    } else if (time < 300) {
      image(img3, 0, 0, width, height);
      fill(50, 190);
      rect(0, height/4, width, height/4);
      fill(255);
      text("Work together to score as much as possible during the time limit!", width/2, height/3);
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

