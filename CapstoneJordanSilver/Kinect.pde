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

    analyseDepthMap();
    doHands();
    imageMode(CORNER);
//    translate(-width/2, -height/2, 0);
    popMatrix();
  }
}

void analyseDepthMap() {
}

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

//void initializeSphere(int numPtsW, int numPtsH_2pi) {
//
//  // The number of points around the width and height
//  numPointsW=numPtsW+1;
//  numPointsH_2pi=numPtsH_2pi;  // How many actual pts around the sphere (not just from top to bottom)
//  numPointsH=ceil((float)numPointsH_2pi/2)+1;  // How many pts from top to bottom (abs(....) b/c of the possibility of an odd numPointsH_2pi)
//
//  coorX=new float[numPointsW];   // All the x-coor in a horizontal circle radius 1
//  coorY=new float[numPointsH];   // All the y-coor in a vertical circle radius 1
//  coorZ=new float[numPointsW];   // All the z-coor in a horizontal circle radius 1
//  multXZ=new float[numPointsH];  // The radius of each horizontal circle (that you will multiply with coorX and coorZ)
//
//  for (int i=0; i<numPointsW; i++) {  // For all the points around the width
//    float thetaW=i*2*PI/(numPointsW-1);
//    coorX[i]=sin(thetaW);
//    coorZ[i]=cos(thetaW);
//  }
//
//  for (int i=0; i<numPointsH; i++) {  // For all points from top to bottom
//    if (int(numPointsH_2pi/2) != (float)numPointsH_2pi/2 && i==numPointsH-1) {  // If the numPointsH_2pi is odd and it is at the last pt
//      float thetaH=(i-1)*2*PI/(numPointsH_2pi);
//      coorY[i]=cos(PI+thetaH); 
//      multXZ[i]=0;
//    } else {
//      //The numPointsH_2pi and 2 below allows there to be a flat bottom if the numPointsH is odd
//      float thetaH=i*2*PI/(numPointsH_2pi);
//
//      //PI+ below makes the top always the point instead of the bottom.
//      coorY[i]=cos(PI+thetaH); 
//      multXZ[i]=sin(thetaH);
//    }
//  }
//}
//
//void textureSphere(float rx, float ry, float rz, PImage t) { 
//  // These are so we can map certain parts of the image on to the shape 
//  float changeU=t.width/(float)(numPointsW-1); 
//  float changeV=t.height/(float)(numPointsH-1); 
//  float u=0;  // Width variable for the texture
//  float v=0;  // Height variable for the texture
//
//  beginShape(TRIANGLE_STRIP);
//  texture(t);
//  for (int i=0; i< (numPointsH-1); i++) {  // For all the rings but top and bottom
//    // Goes into the array here instead of loop to save time
//    float coory=coorY[i];
//    float cooryPlus=coorY[i+1];
//
//    float multxz=multXZ[i];
//    float multxzPlus=multXZ[i+1];
//
//    for (int j=0; j<numPointsW; j++) {  // For all the pts in the ring
//      normal(coorX[j]*multxz, coory, coorZ[j]*multxz);
//      vertex(coorX[j]*multxz*rx, coory*ry, coorZ[j]*multxz*rz, u, v);
//      normal(coorX[j]*multxzPlus, cooryPlus, coorZ[j]*multxzPlus);
//      vertex(coorX[j]*multxzPlus*rx, cooryPlus*ry, coorZ[j]*multxzPlus*rz, u, v+changeV);
//      u+=changeU;
//    }
//    v+=changeV;
//    u=0;
//  }
//  endShape();
//}

