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

class TargetTextStyle {
  static TextStyle headline3(BuildContext context) {
    return Theme.of(context).textTheme.headline3.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
  }
}
