class GameModel {
  static int startSlider = 50;
  static int startTotalScore = 0;
  static int startRound = 1;

  int target;
  int sliderCurrent;
  int currentTotalScore;
  int currentRound;

  GameModel(
      {this.target,
      this.sliderCurrent,
      this.currentRound,
      this.currentTotalScore});
}

GameModel gameModel;
