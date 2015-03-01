class Visualization {
  
  float xRot;
  float yRot;
  float zRot;
  
  float xRotV;
  float yRotV;
  float zRotV;
  
  float xRotA;
  float yRotA;
  float zRotA;
  
  Visualization() {
    xRot = -25;
    yRot = 45;
    zRot = 0;
    
    xRotV = 0;
    yRotV = 0;
    zRotV = 1;
    
    xRotA = 0;
    yRotA = 0;
    zRotA = .08;
   
     
  }
  
  void draw() {
    
    pushMatrix();
    
    translate(0,0,-200);
    
    fill(255);
    fill(227,16,87);
    
    rect(-displayWidth,-displayHeight,displayWidth*3,displayHeight*2);
    
    popMatrix();
    
    pushMatrix();
    
    
    translate(displayWidth/2,displayHeight/2, 0);
    
    rotateX(radians(xRot));
    rotateY(radians(yRot));
    rotateZ(radians(zRot));
    //rotateX(radians(-25));
    //rotateY(radians(45));
    //rotateZ(radians(45));
    
    fill(color(34,65,182));
    
    lights();
    box(debug.getTempo(),debug.getTempo(),debug.getTempo());
    
//    noStroke();
//    sphereDetail(2);
//    sphere(debug.getTempo());
//    stroke(1);

    noLights();
    
    popMatrix();
    
    updateRot();
  }
  
  void updateRot() {
    xRotV += xRotA;
    yRotV += yRotA;
    zRotV += zRotA;
    
    accelerationDecay();
    
    
    xRot += xRotV;
    yRot += yRotV;
    zRot += zRotV; 
    
    velocityDecay  ();
  }
  
  void accelerationDecay() {
      xRotA -= xRotA * .005;
      yRotA -= yRotA * .005;
      zRotA -= zRotA * .005;
  }
  
  void velocityDecay() {
      xRotV -= xRotV * .005;
      yRotV -= yRotV * .005;
      zRotV -= zRotV * .005;
  }
}
