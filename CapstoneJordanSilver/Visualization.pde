//class Visualization {
//
//  float xRot;
//  float yRot;
//  float zRot;
//
//  float xRotV;
//  float yRotV;
//  float zRotV;
//
//  float xRotA;
//  float yRotA;
//  float zRotA;
//
//  float zoom;
//
//  //float 
//
//  Visualization() {
//    xRot = -25;
//    yRot = 45;
//    zRot = 0;
//
//    xRotV = 0;
//    yRotV = 0;
//    zRotV = 0;
//
//    xRotA = 0;
//    yRotA = 0;
//    zRotA = .0;
//
//    zoom = 0;
//  }
//
//  void draw() {
//
//    pushMatrix();
//
//    translate(0, 0, zoom-200);
//
//    fill(255);
//    fill(227, 16, 87);
//
//    // rect(-displayWidth*2,-displayHeight,displayWidth*5,displayHeight*3);
//
//    background(227, 16, 87);
//
//    popMatrix();
//
//    pushMatrix();
//
//    rotateX(radians(30));
//    rotateY(radians(15));
//
//    //if (mousePressed) {
//    lights();
//    lightSpecular(200, 200, 200);
//    directionalLight(204, 204, 204, 0, 0, -1);
//    //ambientLight(102, 102, 102);
//    //}
//
//    popMatrix();
//
//    pushMatrix();
//
//    translate(displayWidth/2, displayHeight/2, zoom);
//
//
//    rotateX(radians(xRot));
//    rotateY(radians(yRot));
//    rotateZ(radians(zRot));
//    //rotateX(radians(-25));
//    //rotateY(radians(45));
//    //rotateZ(radians(45));
//
//    fill(color(34, 65, 182));
//
//    if (mousePressed) {
//      shininess(3.0);
//      emissive(0, 26, 51);
//      specular(150, 150, 150);
//    } else {
//      shininess(1.0);
//      emissive(0, 0, 0);
//      specular(0);
//    }
//
//    box(debug.getTempo(), debug.getTempo(), debug.getTempo());
//
//    translate(-150, -150, 0);
//
//    noStroke();
//    //sphere(debug.getTempo());
//    //textureSphere(200, 200, 200, kinect.getVideoImage());
//    //textureSphere(200, 200, 200, kinect.getDepthImage());
//
//    stroke(1);
//
//    //    box(debug.getTempo(),debug.getTempo(),debug.getTempo()); 
//    //    translate(-150,-150,0);  
//    //    box(debug.getTempo(),debug.getTempo(),debug.getTempo());
//
//    //    noStroke();
//    //    sphereDetail(2);
//    //    sphere(debug.getTempo());
//    //    stroke(1);
//
//    noLights();
//    popMatrix();
//    updateRot();
//  }
//
//  void updateRot() {
//    xRotV += xRotA;
//    yRotV += yRotA;
//    zRotV += zRotA;
//
//    accelerationDecay();
//
//    xRot += xRotV;
//    yRot += yRotV;
//    zRot += zRotV; 
//
//    velocityDecay();
//  }
//
//  void accelerationDecay() {
//
//    //      float aRate = 0.05;
//    //      if(xRotA > 0) {
//    //        xRotA -= aRate;
//    //        if(xRotA < 0)
//    //          xRotA = 0;
//    //      }
//    //      else if(xRotA < 0) {
//    //        xRotA += aRate;
//    //        if(xRotA > 0)
//    //          xRotA = 0;
//    //      }
//    //      if(yRotA > 0) {
//    //        yRotA -= aRate;
//    //        if(yRotA < 0)
//    //          yRotA = 0;
//    //      }
//    //      else if(yRotA < 0) {
//    //        yRotA += aRate;
//    //        if(yRotA > 0)
//    //          yRotA = 0;
//    //      }
//    //      if(zRotA > 0) {
//    //        zRotA -= aRate;
//    //        if(zRotA < 0)
//    //          zRotA = 0;
//    //      }
//    //      else if(zRotA < 0) {
//    //        zRotA += aRate;
//    //        if(zRotA > 0)
//    //          zRotA = 0;
//    //      }
//    xRotA -= xRotA * .01;
//    yRotA -= yRotA * .01;
//    zRotA -= zRotA * .01;
//  }
//
//  void velocityDecay() {
//
//    float vRate = 0.05;
//    if (xRotV > 0) {
//      xRotV -= vRate;
//      if (xRotV < 0)
//        xRotV = 0;
//    } else if (xRotV < 0) {
//      xRotV += vRate;
//      if (xRotV > 0)
//        xRotV = 0;
//    }
//    if (yRotV > 0) {
//      yRotV -= vRate;
//      if (yRotV < 0)
//        yRotV = 0;
//    } else if (yRotV < 0) {
//      yRotV += vRate;
//      if (yRotV > 0)
//        yRotV = 0;
//    }
//    if (zRotV > 0) {
//      zRotV -= vRate;
//      if (zRotV < 0)
//        zRotV = 0;
//    } else if (zRotV < 0) {
//      zRotV += vRate;
//      if (zRotV > 0)
//        zRotV = 0;
//    }
//
//    //xRotV -= xRotV * .01;
//    //yRotV -= yRotV * .01;
//    //zRotV -= zRotV * .01;
//  }
//
//  void accelerateX(float bla) {
//    xRotV += bla;
//    xRotA += (bla/50);
//  }
//
//  void accelerateY(float bla) {
//    yRotV += bla;
//    yRotA += (bla/50);
//  }
//
//  void zoomIn() {
//    zoom += 50;
//    if (zoom > 200)
//      zoom = 200;
//  }
//
//  void zoomOut() {
//    zoom -= 50; 
//    if (zoom < -1000)
//      zoom = -1000;
//  }
//
//  //  void dragOn() {
//  //  }
//  //
//  //  void dragOff() {
//  //  }
//  //
//  //  void drag(int x, int y) {
//  //  }
//}
