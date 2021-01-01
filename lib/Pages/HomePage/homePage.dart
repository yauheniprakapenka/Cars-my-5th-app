import 'package:BullsEye/Controls/hitmeButton.dart';
import 'package:BullsEye/Model/gameModel.dart';
import 'package:BullsEye/Pages/HomePage/sliderRow.dart';
import 'package:BullsEye/Utils/ScoreForRound.dart';
import 'package:BullsEye/Utils/targetNumberGenerator.dart';
import 'package:BullsEye/Views/ResultAlertButton.dart';
import 'package:flutter/material.dart';

import 'goalColumn.dart';
import 'scoreRaw.dart';

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
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoalColumn(),
              SliderRow(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: HitmeButton(
                  text: "Проверить!",
                  onPressed: () {
                    _hitmeButtonPressed();
                  },
                ),
              ),
              ScoreRaw(onStartOver: _newgameButtonPressed)
            ],
          ),
        ),
      ),
    );
  }

  _hitmeButtonPressed() {
    final int scoreForRound = ScoreForRound.get();
    setState(() {
      gameModel.currentRound += 1;
      gameModel.currentTotalScore += scoreForRound;
    });
    ResultAlertDialog().showAlert(
        context: context,
        scoreForRound: scoreForRound,
        onContinuePressed: () {
          Navigator.of(context).pop();
          setState(() {
            gameModel.target = TargetNumberGenerator.generate();
          });
        });
  }

  _newgameButtonPressed() {
    setState(() {
      gameModel = GameModel(
          target: TargetNumberGenerator.generate(),
          currentRound: GameModel.startRound,
          sliderCurrent: GameModel.startSlider,
          currentTotalScore: GameModel.startTotalScore);
    });
  }
}
