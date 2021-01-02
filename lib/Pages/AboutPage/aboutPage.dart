import 'package:BullsEye/Theme/colorStyle.dart';
import 'package:flutter/material.dart';

import '../../Constants/strings.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(Strings.aboutPageTitle),
          backgroundColor: ColorStyle.primaryColor),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                Strings.aboutPageGame,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
            ),
            Text(
              Strings.aboutPageTarget,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            Padding(
              padding: EdgeInsets.all(26.0),
              child: RaisedButton(
                child: Text(Strings.abountPageButtonBack),
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
