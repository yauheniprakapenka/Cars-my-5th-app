import 'package:BullsEye/Theme/colorStyle.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Об игре"), backgroundColor: ColorStyle.primaryColor),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "🌼 Bullseye 🌼",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
            ),
            Text(
              "Целью игры является переместить слайдер\nкак можно ближе к указанной цели.",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            Padding(
              padding: EdgeInsets.all(26.0),
              child: RaisedButton(
                child: Text("Назад"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
