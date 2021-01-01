import 'package:BullsEye/Theme/colorStyle.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  CircleButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: onPressed,
        fillColor: Colors.white,
        splashColor: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: ColorStyle.primaryColor,
          ),
        ),
        shape: CircleBorder(side: BorderSide(color: Colors.white)));
  }
}
