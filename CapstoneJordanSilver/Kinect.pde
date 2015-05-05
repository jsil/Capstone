import SimpleOpenNI.*;

import java.util.Map;
import java.util.Iterator;

//Kinect kinect;
SimpleOpenNI kinect;

boolean didKinect;

int handVecListSize = 20;
Map<Integer, ArrayList<PVector>>  handPathList = new HashMap<Integer, ArrayList<PVector>>();

color[]       userClr = new color[] { 
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(0, 255, 255)
};

void doKinect() {
  //LEDStatus LED_OFF;
  kinect = new SimpleOpenNI(this);
  //  kinect.start();
  kinect.enableDepth();
  kinect.enableRGB();
  //kinect.enableIR();
  //  kinect.tilt(0); 
  //  kinect.setLEDStatus(LED_OFF);
  //kinect.getDepthImage();
  kinect.setMirror(true);
  kinect.enableHand();
  kinect.startGesture(SimpleOpenNI.GESTURE_WAVE);

  didKinect = true;
}

void drawKinect() {
  if (didKinect) {
    kinect.update();

    pushMatrix();
    translate(250, 150, 0);
//    scale(1+((4/3)-(16/9)),1);
    tint(255, 140);
    image(kinect.depthImage(), 0, 0); 
    noTint();    

    doHands();
    imageMode(CORNER);
//    translate(-width/2, -height/2, 0);
    popMatrix();
  }
}

//From SimpleOpenNI demo
//TODO: remake
void doHands() {
  if (handPathList.size() > 0)  
  {    
    Iterator itr = handPathList.entrySet().iterator();     
    while (itr.hasNext ())
    {
      Map.Entry mapEntry = (Map.Entry)itr.next(); 
      int handId =  (Integer)mapEntry.getKey();
      ArrayList<PVector> vecList = (ArrayList<PVector>)mapEntry.getValue();
      PVector p;
      PVector p2d = new PVector();

      stroke(userClr[ (handId - 1) % userClr.length ]);
      noFill(); 
      strokeWeight(1);        
      Iterator itrVec = vecList.iterator(); 
      beginShape();
      while ( itrVec.hasNext () ) 
      { 
        p = (PVector) itrVec.next(); 

        kinect.convertRealWorldToProjective(p, p2d);
        vertex(p2d.x, p2d.y);
      }
      endShape();   

      stroke(userClr[ (handId - 1) % userClr.length ]);
      strokeWeight(4);
      p = vecList.get(0);
      kinect.convertRealWorldToProjective(p, p2d);
      point(p2d.x, p2d.y);
    }
  }
}

void onNewHand(SimpleOpenNI curContext, int handId, PVector pos)
{
  println("onNewHand - handId: " + handId + ", pos: " + pos);

  ArrayList<PVector> vecList = new ArrayList<PVector>();
  vecList.add(pos);

  handPathList.put(handId, vecList);
}

void onTrackedHand(SimpleOpenNI curContext, int handId, PVector pos)
{
  //println("onTrackedHand - handId: " + handId + ", pos: " + pos );

  ArrayList<PVector> vecList = handPathList.get(handId);
  if (vecList != null)
  {
    vecList.add(0, pos);
    if (vecList.size() >= handVecListSize)
      // remove the last point 
      vecList.remove(vecList.size()-1);
  }
}

void onLostHand(SimpleOpenNI curContext, int handId)
{
  println("onLostHand - handId: " + handId);
  handPathList.remove(handId);
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
