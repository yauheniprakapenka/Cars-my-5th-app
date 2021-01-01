import 'package:BullsEye/Model/gameModel.dart';
import 'package:BullsEye/Utils/ScoreForRound.dart';
import 'package:BullsEye/Utils/titleResult.dart';
import 'package:flutter/material.dart';

import 'ContinueAlertDialogButton.dart';

class ResultAlertDialog {
  showAlert(
      BuildContext context, int scoreForRound, Function() onContinuePressed) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("${TitleResult.get(scoreForRound)}"),
              content: Text(
                "Slider ${gameModel.sliderCurrent}" +
                    " : ${gameModel.target} Target" +
                    "\n\nYour score is ${ScoreForRound.get()}",
                textAlign: TextAlign.center,
              ),
              actions: [
                ContinueAlertButton(onContinuePressed: onContinuePressed),
              ]);
        });
  }
}
