import 'package:flutter/material.dart';

class HitmeButton extends StatelessWidget {
  HitmeButton({@required this.text, @required this.onPressed});

  final String text;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(minWidth: 160),
      onPressed: onPressed,
      fillColor: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          this.text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white, width: 2),
      ),
    );
  }
}
