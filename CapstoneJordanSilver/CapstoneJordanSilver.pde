//Jordan Silver
//Capstone


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


int sketchWidth() {
  return displayWidth;
}

int sketchHeight() {
  return displayHeight-150;
}

String sketchRenderer() {
  return P3D;
}


void setup() {
  frame.setTitle("Jordan Silver - Capstone");
  frame.setResizable(true);

  doMenu();

  size(sketchWidth(), sketchHeight(), sketchRenderer()); 
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
