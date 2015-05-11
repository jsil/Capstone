class Hands {


  int handVecListSize = 20;
  //  Map<Integer, ArrayList<PVector>>  handPathList = new HashMap<Integer, ArrayList<PVector>>();
  ArrayList<Hand> handList = new ArrayList<Hand>();

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
    for (int i=0; i<handList.size (); i++) {
      int handId = handList.get(i).getHandId();
      ArrayList<PVector> vecList = handList.get(i).getVectorList();

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

    strokeWeight(1);




    //    if (handPathList.size() > 0)  
    //    {    
    //      Iterator itr = handPathList.entrySet().iterator();     
    //      while (itr.hasNext ())
    //      {
    //        Map.Entry mapEntry = (Map.Entry)itr.next(); 
    //        int handId =  (Integer)mapEntry.getKey();
    //        ArrayList<PVector> vecList = (ArrayList<PVector>)mapEntry.getValue();
    //        PVector p;
    //        PVector p2d = new PVector();
    //
    //        stroke(userClr[ (handId - 1) % userClr.length ]);
    //        noFill(); 
    //        strokeWeight(1);        
    //        Iterator itrVec = vecList.iterator(); 
    //        beginShape();
    //        while ( itrVec.hasNext () ) 
    //        { 
    //          p = (PVector) itrVec.next(); 
    //
    //          kinect.convertRealWorldToProjective(p, p2d);
    //          vertex(p2d.x, p2d.y);
    //        }
    //        endShape();   
    //
    //        stroke(userClr[ (handId - 1) % userClr.length ]);
    //        strokeWeight(4);
    //        p = vecList.get(0);
    //        kinect.convertRealWorldToProjective(p, p2d);
    //        point(p2d.x, p2d.y);
    //      }
    //    }
    //    strokeWeight(1);
  }

  int size() {
    return handList.size();
  }


  Hand getHand(int handId) {
    for (int i=0; i<handList.size (); i++) {
      if (handList.get(i).getHandId() == handId) {
        return handList.get(i);
      }
    }
    return null;
  }

  void newHand(int handId, PVector pos) {

    ArrayList<PVector> vecList = new ArrayList<PVector>();
    vecList.add(pos);

    //    handPathList.put(handId, vecList);
    handList.add(new Hand(handId, vecList));
    gm.addUser(handId);
  }

  void trackedHand(int handId, PVector pos) {
    ArrayList<PVector> vecList = getHand(handId).getVectorList();
    if (vecList != null)
    {
      vecList.add(0, pos);
      if (vecList.size() >= handVecListSize)
        // remove the last point 
        vecList.remove(vecList.size()-1);
    }
  }

  void lostHand(int handId) {
    println("removing hand");
    for (int i=0; i<handList.size (); i++) {
      if (handList.get(i).getHandId() == handId) {
        println("found hand");
        handList.remove(i);
        println("removed hand");
        gm.lostUser(handId);
        println("removed from gm");
        break;
      }
    }
  }

  boolean getBinarySelection(int handId) {
    if (getXPos(handId) >= 0) {
      return true;
    } else {
      return false;
    }
  }

  int getQuadrantSelection(int handId) {
    if (getXPos(handId) >= 0) {
      if (getYPos(handId) >= 0) {
        return 2;
      } else {
        return 4;
      }
    } else {
      if (getYPos(handId) >= 0) {
        return 1;
      } else {
        return 3;
      }
    }
  }

  int getQuadrantSelection2(int handId) {
    if (getXPos(handId) >= 100) {
      if (getYPos(handId) >= 100) {
        return 2;
      } else if (getYPos(handId) <= -100) {
        return 4;
      } else {
        return -1;
      }
    } else if (getXPos(handId) <= -100) {
      if (getYPos(handId) >= 0) {
        return 1;
      } else if (getYPos(handId) <= -100) {
        return 3;
      } else {
        return -1;
      }
    } else {
      return -1;
    }
  }

  float getXPos(int handId) {
    ArrayList<PVector> vecList = getHand(handId).getVectorList();
    return vecList.get(0).x;
  }

  float getYPos(int handId) {
    ArrayList<PVector> vecList = getHand(handId).getVectorList();
    return vecList.get(0).y;
  }

  ArrayList<Integer> getAllHands() {
    ArrayList<Integer> returnedHands = new ArrayList<Integer>();
    for (int i=0; i<handList.size (); i++) {
      returnedHands.add(handList.get(i).getHandId());
    } 
    return returnedHands;
  }
}

