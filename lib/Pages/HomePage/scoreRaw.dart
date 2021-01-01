import 'package:BullsEye/Controls/circleButton.dart';
import 'package:BullsEye/Model/gameModel.dart';
import 'package:BullsEye/Pages/AboutPage/aboutPage.dart';
import 'package:BullsEye/Theme/textStyle.dart';
import 'package:flutter/material.dart';

class ScoreRaw extends StatelessWidget {
  ScoreRaw({Key key, @required this.onStartOver}) : super(key: key);

  final GestureTapCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _makeStartOverButton(context),
        Padding(
            padding: EdgeInsets.only(left: 32),
            child: _makeText(context, "Очки:\n${gameModel.currentTotalScore}")),
        Padding(
            padding: EdgeInsets.only(left: 32),
            child: _makeText(context, "Раунд:\n${gameModel.currentRound}")),
        _makeInfoButton(context)
      ],
    );
  }

  _makeStartOverButton(BuildContext context) {
    return CircleButton(
      onPressed: () {
        onStartOver();
      },
      icon: Icons.refresh,
    );
  }

  _makeInfoButton(BuildContext context) {
    return CircleButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AboutPage()));
        },
        icon: Icons.info_outline);
  }

  _makeText(BuildContext context, String text) {
    return Text(
      text,
      style: LabelTextStyle.bodyText1(context),
      textAlign: TextAlign.center,
    );
  }
}
