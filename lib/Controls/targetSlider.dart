import 'package:BullsEye/Model/gameModel.dart';
import 'package:BullsEye/Theme/colorStyle.dart';
import 'package:flutter/material.dart';

class TargetSlider extends StatefulWidget {
  @override
  _TargetSliderState createState() => _TargetSliderState();
}

class _TargetSliderState extends State<TargetSlider> {
  double _currentValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          inactiveTrackColor: Colors.white,
          thumbColor: ColorStyle.primaryColor),
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
