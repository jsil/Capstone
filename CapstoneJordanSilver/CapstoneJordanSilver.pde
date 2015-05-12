//Jordan Silver
//Capstone

/*
TO DO:
 take/save picture
 
 figure out why kinect isn't working
 add basic sound
 integrate pd tempo to tweet beat
 make tweet beat tweets move
 
 post a tweet
 3rd game 
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
boolean KINECT = true;

Hands hands;

void setup() {
  frame.setTitle("Jordan Silver - Capstone");
  frame.setResizable(true);

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

  hands = new Hands();
  gm = new GameManager();

  defaultFont = loadFont("YeOldFont.vlw");

  gm.loadGameMode(0);
}

void draw() {
  gm.draw();
  if (DEBUG)
    debug.draw();
  pushMatrix();
  popMatrix();
}

