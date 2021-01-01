import 'package:flutter/material.dart';

class CustomAlertButton extends StatelessWidget {
  CustomAlertButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(onPressed: onPressed, child: Text("Продолжить"));
  }
}
