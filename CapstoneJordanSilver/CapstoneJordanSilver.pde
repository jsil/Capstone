//Jordan Silver
//Capstone
<<<<<<< HEAD

//test
=======
>>>>>>> b28e00e5adda4918f0462945aa8312d081d23fef
  
import oscP5.*;//sends messages to pure data
import netP5.*;//connects to pure data
import controlP5.*;//GUI controls for debug
import twitter4j.conf.*;//Twitter library
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

OscP5 oscP5;
NetAddress pureData;   

//CheckBox checkbox;

ConfigurationBuilder  cb = new ConfigurationBuilder();
Twitter twitterInstance;
Query queryForTwitter;

//float displayWidth = 800;
//float displayHeight = 600;
float xRot = 0;
float yRot = 0;
float zRot = 0;
  
Debug debug;

Slider abc;

void setup() {
   size(displayWidth, displayHeight-150, P3D); 
   frameRate(25);
   
   ControlP5 cp5;
   cp5 = new ControlP5(this);
   debug = new Debug(cp5);
   oscP5 = new OscP5(this,9002);
   pureData = new NetAddress("127.0.0.1",9001);
   doTwitter();
}

void draw() {
  fill(255);
  fill(227,16,87);
  rect(0,0,displayWidth,displayHeight);
  
  debug.draw();
  
//  noFill();
//  translate(displayWidth/2,displayHeight/2, 0);
//  rotate(60,50+xRot,50+5*(yRot*yRot),0+zRot);
//  box(50,50,50);
//  translate(0,0,0);
}

void keyPressed() {
  if(focused) {
     if(key == CODED) {
        if(keyCode == UP) {
           yRot = yRot + .5;
        } 
        if(keyCode == LEFT) {
           oscP5.send(new OscMessage("/test").add(5), pureData);
           println("Sent"); 
        } 
     }
  } 
  
}

void mouseClicked() {
   debug.click(mouseX, mouseY); 
}
