//Jordan Silver
//Capstone

/*
TO DO:
 add more this or that words
 figure out why everything crashes and burns

 now-12:
 improve this or that display 
 fix background crash 
 12-2:
 figure out layering on menu pie text
 hashtag tag game
 kinect compatibility with sub-menu
 
 2-4:
 add basic sound
 integrate pd tempo to tweet beat
 
 4-8:30: sleep
 
 9-11:30:
 add intros
 
 11:30-1:30:
 
 
FUTURE GOALS:
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
//Visualization vis;
GameManager gm;

PFont defaultFont;

boolean installation = false;
boolean DEBUG = false;
boolean KINECT = false;

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
//  vis = new Visualization();
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

