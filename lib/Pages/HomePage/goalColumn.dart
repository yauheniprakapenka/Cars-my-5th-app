import 'package:BullsEye/Model/gameModel.dart';
import 'package:BullsEye/Theme/textStyle.dart';
import 'package:flutter/material.dart';

class GoalColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Переместите слайдер как можно ближе к цели",
          style: LabelTextStyle.bodyText1(context),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("${gameModel.target}",
              style: TargetTextStyle.headline3(context)),
        )
      ],
    );
  }
}
