//Jordan Silver
//Capstone

/*
TO DO:
  Re-organize, clean, comment code
  standardize classes
  Kinect controls
  timed game rounds
  3-lane game
  take/save picture
  post a tweet
  3rd game?


*/


import oscP5.*;//sends messages to pure data
import netP5.*;//connects to pure data
import controlP5.*;//GUI controls for debug


import java.util.*;


//import org.openkinect.*;//Kinect library
//import org.openkinect.processing.*;


OscP5 oscP5;
NetAddress pureData;   



Debug debug;
Visualization vis;


GameManager gm;

//int ptsW, ptsH;
//PImage img;
//int numPointsW;
//int numPointsH_2pi; 
//int numPointsH;
//float[] coorX;
//float[] coorY;
//float[] coorZ;
//float[] multXZ;

PFont defaultFont;

boolean installation = false;
boolean DEBUG = false;
boolean KINECT = false;

void setup() {
  frame.setTitle("Jordan Silver - Capstone");
  frame.setResizable(true);

  doMenu();
  if(KINECT)
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
  doTwitter();


  gm = new GameManager();
 

  //  ptsW=30;
  //  ptsH=30;
  //  // Parameters below are the number of vertices around the width and height
  //  initializeSphere(ptsW, ptsH); 



  defaultFont = loadFont("YeOldFont.vlw");


  gm.loadGameMode(0);

}

void draw() {
  //blendMode(ADD);

  gm.draw();
  if(DEBUG)
    debug.draw();
  pushMatrix();
  drawKinect();
  popMatrix();
}
