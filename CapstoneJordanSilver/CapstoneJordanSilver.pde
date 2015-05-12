//Jordan Silver
//Capstone

/*
TO DO:
 add more this or that words
 figure out why everything crashes and burns

 now-11:
 improve this or that display 
 fix background crash 
 finish hash tag game
 
 11:30-1:30:
 clean up code
 add intros
 add basic sound
 integrate pd tempo to tweet beat
 
 
FUTURE GOALS:
 kinect compatibility with sub-menu
 figure out layering on menu pie text
 post a tweet
 take/save picture
 */

import oscP5.*;//sends messages to pure data
import netP5.*;//connects to pure data
import controlP5.*;//GUI controls for debug
import java.util.*;

OscP5 oscP5;
NetAddress pureData;   

Debug debug;
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

