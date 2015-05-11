class Hand {

  int handId;
  color handColor;
  ArrayList<PVector> vecList = new ArrayList<PVector>();
  int score = 0;

  Hand(int handIdSet, ArrayList<PVector> vecListSet) {
    handId = handIdSet;
    vecList = vecListSet;
  } 

  int getHandId() {
    return handId;
  }

  ArrayList<PVector> getVectorList() {
    return vecList;
  }

  int getScore() {
    return score;
  }

  void addPoints(int points) {
    score += points;
  }

  void subtractPoints(int points) {
    score -= points;
  }
}

