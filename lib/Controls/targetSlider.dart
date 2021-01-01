import 'package:BullsEye/Model/gameModel.dart';
import 'package:BullsEye/Theme/textstyles.dart';
import 'package:flutter/material.dart';

class SliderControl extends StatefulWidget {
  @override
  _SliderControlState createState() => _SliderControlState();
}

class _SliderControlState extends State<SliderControl> {
  double _currentValue = 50.0;
  static const _edgeInsets = 32.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: _edgeInsets),
          child: Text(
            "1",
            style: LabelTextStyle.bodyText1(context),
          ),
        ),
        Expanded(
          child: _makeSlider(context),
        ),
        Padding(
          padding: const EdgeInsets.only(right: _edgeInsets),
          child: Text(
            "100",
            style: LabelTextStyle.bodyText1(context),
          ),
        )
      ],
    );
  }

  _makeSlider(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          inactiveTrackColor: Colors.white, thumbColor: Color(0xffDCE04C)),
      child: Slider(
        value: gameModel.sliderCurrent.toDouble(),
        min: 1.0,
        max: 100.0,
        onChanged: (double value) {
          setState(() {
            _currentValue = value;
            gameModel.sliderCurrent = _currentValue.toInt();
          });
        },
      ),
    );
  }
}
