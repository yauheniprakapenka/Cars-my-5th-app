import 'package:flutter/material.dart';

class LabelTextStyle {
  static TextStyle bodyText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
          color: Colors.white,
        );
  }
}

// class ScoreNumbersTextStyle {
//   static TextStyle headline4(BuildContext context) {
//     return Theme.of(context)
//         .textTheme
//         .headline4
//         .copyWith(fontWeight: FontWeight.bold, color: Colors.white);
//   }
// }

class TargetTextStyle {
  static TextStyle bodyText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.bold, fontSize: 32.0, color: Colors.yellow);
  }
}
