import 'package:flutter/material.dart';

import '../Constants/strings.dart';

class ContinueAlertButton extends StatelessWidget {
  ContinueAlertButton({@required this.onContinuePressed});

  final GestureTapCallback onContinuePressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onContinuePressed,
        child: Text(Strings.resultAlertDialogButtonContinue));
  }
}
