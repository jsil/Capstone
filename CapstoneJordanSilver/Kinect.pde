void doKinect() {
  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);
  //kinect.enableRGB(rgb);
  //kinect.enableIR(ir);
  kinect.tilt(0); 
}

void drawKinect() {
  //image(kinect.getVideoImage(),0,0);
  pushMatrix();
  scale(-1.0, 1.0);
  image(kinect.getDepthImage(),0,0,200,150); 
  popMatrix();
}

void stop() {
  kinect.quit();
  super.stop();
}
