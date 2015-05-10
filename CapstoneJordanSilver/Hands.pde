class Hands {


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

  Hands() {
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
    strokeWeight(1);
  }

  void newHand(int handId, PVector pos) {

    ArrayList<PVector> vecList = new ArrayList<PVector>();
    vecList.add(pos);

    handPathList.put(handId, vecList);
    gm.addUser(handId);
  }

  void trackedHand(int handId, PVector pos) {
    ArrayList<PVector> vecList = handPathList.get(handId);
    if (vecList != null)
    {
      vecList.add(0, pos);
      if (vecList.size() >= handVecListSize)
        // remove the last point 
        vecList.remove(vecList.size()-1);
    }
  }

  void lostHand(int handId) {
    handPathList.remove(handId);
    gm.lostUser(handId);
  }
  
  boolean getBinarySelection(int handId) {
     if(getXPos(handId) >= 0) {
        return true; 
     }
     else {
       return false; 
     }
  }
  
  float getXPos(int handId) {
     ArrayList<PVector> vecList = handPathList.get(handId);
     return vecList.get(vecList.size()-1).x; 
  }
  
  ArrayList<Integer> getAllHands() {
     ArrayList<Integer> returnedHands = new ArrayList<Integer>();
     for(int i=0;i<handPathList.size();i++) {
//        if(handPathList.containsKey(i)) {
           returnedHands.add(i); 
//        }
     } 
     return returnedHands;
  }
}
