//Jordan Silver
//Capstone
  
import oscP5.*;//sends messages to pure data
import netP5.*;//connects to pure data
import controlP5.*;//GUI controls for debug
import twitter4j.conf.*;//Twitter library
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;
import org.openkinect.*;//Kinect library
import org.openkinect.processing.*;

OscP5 oscP5;
NetAddress pureData;   

ConfigurationBuilder cb = new ConfigurationBuilder();
Twitter twitterInstance;
Query queryForTwitter;

Kinect kinect;

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

int drawCount;

void setup() {
   size(displayWidth, displayHeight-150, P3D); 
   frameRate(25);
   
   ControlP5 cp5;
   cp5 = new ControlP5(this);
   debug = new Debug(cp5);
   vis = new Visualization();
   oscP5 = new OscP5(this,9002);
   pureData = new NetAddress("127.0.0.1",9001);
   
   oscP5.send(new OscMessage("/start").add(1), pureData);
   
   startTwitter();
   doTwitter();
   //doKinect();
   
   //ortho(0, width, 0, height);
  
  ptsW=30;
  ptsH=30;
  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH); 
  
  drawCount = 0;
   
}

void draw() {
  //blendMode(ADD);
  pushMatrix();
  //beginCamera();
  translate(0,0,-150);
  vis.draw();
//  noFill();
//  translate(displayWidth/2,displayHeight/2, 0);
//  rotate(60,50+xRot,50+5*(yRot*yRot),0+zRot);
//  box(50,50,50);
//  translate(0,0,0);
  popMatrix();
  
  //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);//rotate
  //camera(mouseX, height/2, (height/2) / tan(PI/6), mouseX, height/2, 0, 0, 1, 0);//pan
  blendMode(BLEND);
  //endCamera();
  //translate(-screenX(0,0,0),-screenY(0,0,0),-screenZ(0,0,0));//makes console blurry.
  
  pushMatrix();
  translate(1110,86,150);
  //drawKinect();
  popMatrix();
  
  debug.draw();
  
  drawCount++;
}

void keyPressed() {
  if(focused) {
     if(key == CODED) {
        if(keyCode == UP) {
           ;
        } 
        if(keyCode == LEFT) { 
           vis.accelerateY(-1);
        } 
        if(keyCode == RIGHT) {
            vis.accelerateY(1);
        }
     }
     else {
        if(key == 'z') {
           vis.zoomIn();
        }
        else if(key == 'x') {
           vis.zoomOut(); 
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
