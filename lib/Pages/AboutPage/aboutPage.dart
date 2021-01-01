import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("About game"), backgroundColor: Colors.red[700]),
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
              "This is the game where you can win pois by dragging slider",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Go back"),
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
