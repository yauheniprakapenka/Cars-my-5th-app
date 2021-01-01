import 'package:BullsEye/Model/gameModel.dart';
import 'package:BullsEye/Utils/ScoreForRound.dart';
import 'package:BullsEye/Utils/titleResult.dart';
import 'package:flutter/material.dart';

import 'ContinueAlertDialogButton.dart';

class ResultAlertDialog {
  showAlert(
      {BuildContext context, int scoreForRound, Function() onContinuePressed}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("${TitleResult.get(scoreForRound)}"),
              content: Text(
                "На слайдере ${gameModel.sliderCurrent}" +
                    " , Ваша цель ${gameModel.target}" +
                    "\n\Заработано ${ScoreForRound.get()} очков",
                textAlign: TextAlign.center,
              ),
              actions: [
                ContinueAlertButton(onContinuePressed: onContinuePressed),
              ]);
        });
  }
}
