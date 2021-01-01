import 'package:BullsEye/Model/gameModel.dart';
import 'package:BullsEye/Theme/textstyles.dart';
import 'package:flutter/material.dart';

class Goal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Put the bullseye as close as you can to",
          style: LabelTextStyle.bodyText1(context),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("${gameModel.target}",
              style: TargetTextStyle.bodyText1(context)),
        )
      ],
    );
  }
}
