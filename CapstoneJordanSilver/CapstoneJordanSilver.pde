//Jordan Silver
//Capstone


import oscP5.*;//sends messages to pure data
import netP5.*;//connects to pure data
import controlP5.*;//GUI controls for debug

import twitter4j.util.*;
import twitter4j.*;
import twitter4j.management.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.auth.*;

import java.util.*;


//import org.openkinect.*;//Kinect library
//import org.openkinect.processing.*;

import SimpleOpenNI.*;

OscP5 oscP5;
NetAddress pureData;   

ConfigurationBuilder cb = new ConfigurationBuilder();
Twitter twitterInstance;
Query queryForTwitter;

//Kinect kinect;
SimpleOpenNI kinect;

//float displayWidth = 800;//uncomment for web use
//float displayHeight = 600;

Debug debug;
Visualization vis;

int ptsW, ptsH;
PImage img;
int numPointsW;
int numPointsH_2pi; 
int numPointsH;
float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;

PFont defaultFont;

boolean paused;

ThisOrThat game1;


void setup() {
  frame.setTitle("Jordan Silver - Capstone");
  frame.setResizable(true);

  doMenu();

  size(displayWidth, displayHeight-150, P3D); 
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


  //  ptsW=30;
  //  ptsH=30;
  //  // Parameters below are the number of vertices around the width and height
  //  initializeSphere(ptsW, ptsH); 



  defaultFont = loadFont("YeOldFont.vlw");

  paused = true;


  loadGameMode(0);
}

void draw() {
  //blendMode(ADD);

  if (debug.getGameMode() == 0) {
    pushMatrix();
    background(48, 55, 95);
    text("To Do: Add Menu", displayWidth/2-10, 300);
    popMatrix();
  } else if (debug.getGameMode() == 1) {
    pushMatrix();
    background(48, 55, 95);
    //text("Game 1", displayWidth/2-10, 15);
    game1.draw();
    popMatrix();
  } else {

    pushMatrix();
    textFont(defaultFont);
    translate(0, 0, -150);
    vis.draw();

    popMatrix();

    blendMode(BLEND);

    pushMatrix();
    translate(1110, 86, 150);
    popMatrix();


    if (!paused) {
      drawKinect();
      drawTwitter();
      drawCamera();
    }
  }
  debug.draw();
}

void keyPressed() {
  if (focused) {
    if (key == CODED) {
      if (keyCode == UP) {
        ;
      } 
      if (keyCode == LEFT) { 
        vis.accelerateY(-1);
      } 
      if (keyCode == RIGHT) {
        vis.accelerateY(1);
      }
    } else {
      if (key == 'z') {
        vis.zoomIn();
      } else if (key == 'x') {
        vis.zoomOut();
      } else if (key == 'p') {
        paused = !paused;
      } else if (key == '1') {
        sampleSend(1);
      } else if (key == '2') {
        sampleSend(2);
      }
    }
  }
}

void mouseClicked() {
  debug.click(mouseX, mouseY);
}

void mousePressed() {
  vis.dragOn();
}

void mouseReleased() {
  vis.dragOff();
}

void mouseDragged() {
  vis.drag(mouseX, mouseY);
}


void loadGameMode(int mode) {
  println("Loading Game " + mode);
  if (mode == 0) {
    debug.setGameMode(mode);
  } else if (mode == 1) {
    debug.setGameMode(mode);
    game1 = new ThisOrThat();

    paused = false;
  } else if (mode == 2) {
    debug.setGameMode(mode);
    paused = false;
  }

  //doKinect();
}

