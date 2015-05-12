import SimpleOpenNI.*;

import java.util.Map;
import java.util.Iterator;

//Kinect kinect;
SimpleOpenNI kinect;

boolean didKinect;

void doKinect() {
  //LEDStatus LED_OFF;
  kinect = new SimpleOpenNI(this);
  //  kinect.start();
  kinect.enableDepth();
  kinect.enableRGB();
//  kinect.isInit();
  //kinect.enableIR();
  //  kinect.tilt(0); 
  //  kinect.setLEDStatus(LED_OFF);
  //kinect.getDepthImage();
  kinect.setMirror(true);
  kinect.enableHand();
  kinect.startGesture(SimpleOpenNI.GESTURE_WAVE);
//  kinect.startGesture(SimpleOpenNI.GESTURE_CLICK);

  if(kinect.isInit()) {
    didKinect = true;
  }
  else {
     println("KINECT NOT LOADED"); 
  }
}

void drawKinect(int mode) {
  if (didKinect) {
    kinect.update();
//    println("drawing kinect");
    pushMatrix();
    if(mode == 0) {
      translate(width*.2, 220, 0);
      scale((width*.6)/kinect.depthWidth(), 1.04);
    }
    else if(mode == 1) {
    translate(250, 150, 0);
    }
    else {
      translate(width*.2, height/2, -600);
      scale((width*.4)/kinect.depthWidth(), 1.04);
    }
//    scale(1+((4/3)-(16/9)),1);
    tint(255, 140);
    image(kinect.depthImage(), 0, 0); 
    noTint();    
    hands.doHands();
    imageMode(CORNER);
//    translate(-width/2, -height/2, 0);
    popMatrix();
  }
}

void onNewHand(SimpleOpenNI curContext, int handId, PVector pos)
{
  println("onNewHand - handId: " + handId + ", pos: " + pos);
  hands.newHand(handId, pos);
}

void onTrackedHand(SimpleOpenNI curContext, int handId, PVector pos)
{
//  println("onTrackedHand - handId: " + handId + ", pos: " + pos );
  hands.trackedHand(handId, pos);
}

void onLostHand(SimpleOpenNI curContext, int handId)
{
  println("onLostHand - handId: " + handId);
  hands.lostHand(handId);
}

// -----------------------------------------------------------------
// gesture events

void onCompletedGesture(SimpleOpenNI curContext, int gestureType, PVector pos)
{
  println("onCompletedGesture - gestureType: " + gestureType + ", pos: " + pos);

  int handId = kinect.startTrackingHand(pos);
  println("hand stracked: " + handId);
}


//void stop() {
//  kinect.quit();
//  super.stop();
//}
