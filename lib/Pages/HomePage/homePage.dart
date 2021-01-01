import 'package:BullsEye/Controls/hitmeButton.dart';
import 'package:BullsEye/Model/gameModel.dart';
import 'package:BullsEye/Controls/targetSlider.dart';
import 'package:BullsEye/Views/alertDialog.dart';
import 'package:BullsEye/utils/randomNumberGenerator.dart';
import 'package:flutter/material.dart';

import 'goal.dart';
import 'score.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _newgameButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("images/bg.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Goal(),
              SliderControl(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: HitmeButton(
                  text: "Hit me!",
                  onPressed: () {
                    _hitmeButtonPressed();
                  },
                ),
              ),
              Score(onStartOver: _newgameButtonPressed)
            ],
          ),
        ),
      ),
    );
  }

  _hitmeButtonPressed() {
    int scoreForRound = _getScoreForRound();
    setState(() {
      gameModel.currentRound += 1;
      gameModel.currentTotalScore += scoreForRound;
    });
    _showAlert(context, scoreForRound);
  }

  _newgameButtonPressed() {
    setState(() {
      gameModel = GameModel(
          target: RandomNumberGenerator.generate(),
          currentRound: GameModel.startRound,
          sliderCurrent: GameModel.startSlider,
          currentTotalScore: GameModel.startTotalScore);
    });
  }

  _showAlert(BuildContext context, int scoreForRound) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("${_getTitleResult(scoreForRound)}"),
              content: Text("Slider is ${gameModel.sliderCurrent}" +
                  "\nTarget is ${gameModel.target}" +
                  "\nYour score is ${_getScoreForRound()}"),
              actions: [
                CustomAlertButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      gameModel.target = RandomNumberGenerator.generate();
                    });
                  },
                )
              ]);
        });
  }

  _getDifferenceTargetAndCurrent() {
    return (gameModel.target - gameModel.sliderCurrent).abs();
  }

  _getScoreForRound() {
    int maxSliderValue = 100;
    int playerScore = maxSliderValue - _getDifferenceTargetAndCurrent();
    int absPlayerScore = playerScore.abs();
    return absPlayerScore;
  }

  _getTitleResult(int scoreForRound) {
    String title;
    if (97 <= scoreForRound) {
      title = "Отлично!";
    } else if (95 <= scoreForRound) {
      title = "Хорошо";
    } else {
      title = "Мимо";
    }
    return title;
  }
}
