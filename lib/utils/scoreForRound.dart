import 'package:BullsEye/Model/gameModel.dart';

class ScoreForRound {
  static get() {
    int maxSliderValue = 100;
    int playerScore = maxSliderValue - _getDifferenceTargetAndCurrent();
    int absPlayerScore = playerScore.abs();
    return absPlayerScore;
  }

  static _getDifferenceTargetAndCurrent() {
    return (gameModel.target - gameModel.sliderCurrent).abs();
  }
}
