import 'package:BullsEye/Controls/targetSlider.dart';
import 'package:BullsEye/Theme/textstyles.dart';
import 'package:flutter/material.dart';

class SliderRow extends StatefulWidget {
  @override
  _SliderRowState createState() => _SliderRowState();
}

class _SliderRowState extends State<SliderRow> {
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
          child: TargetSlider(),
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
}
