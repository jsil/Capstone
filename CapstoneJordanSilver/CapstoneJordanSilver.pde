//Jordan Silver
//Capstone

/*
TO DO:
 friday:
 Kinect controls
 round switching, etc for this/that
 standardize classes
 take/save picture
 3-lane game
 post a tweet
 make menu pretty (photoshop, etc)
 3rd game
 5 landscapes?
 4 self-portraits
 1.5 pages
 saturday:
 1.5 pages
 sunday:
 1.5 pages
 
 */

import oscP5.*;//sends messages to pure data
import netP5.*;//connects to pure data
import controlP5.*;//GUI controls for debug
import java.util.*;

OscP5 oscP5;
NetAddress pureData;   

Debug debug;
Visualization vis;
GameManager gm;

PFont defaultFont;

boolean installation = false;
boolean DEBUG = false;
boolean KINECT = false;

void setup() {
  frame.setTitle("Jordan Silver - Capstone");
  frame.setResizable(false);

  doMenu();

  if (KINECT)
    doKinect();

  size(displayWidth, displayHeight, P3D); 
  frameRate(24);

  ControlP5 cp5;
  cp5 = new ControlP5(this);
  debug = new Debug(cp5);
  vis = new Visualization();
  oscP5 = new OscP5(this, 9002);
  pureData = new NetAddress("127.0.0.1", 9001);

  oscP5.send(new OscMessage("/start").add(1), pureData);

  startTwitter();

  gm = new GameManager();

  defaultFont = loadFont("YeOldFont.vlw");

  gm.loadGameMode(0);
}

void draw() {
  gm.draw();
  if (DEBUG)
    debug.draw();
  pushMatrix();
  drawKinect();
  popMatrix();
}

