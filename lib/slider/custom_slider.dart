import 'package:custom_slider/common_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_colors.dart';

class CustomSlider extends StatefulWidget {
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _currentValue = 0;
  double _initialValue = 20;
  double _trackHeight = 10.0;

  @override
  void initState() {
    _currentValue = _initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.amber,
        trackHeight: _trackHeight,
        valueIndicatorColor: CommonColors.valueIndicatorColor,
        showValueIndicator: ShowValueIndicator.onlyForContinuous,
        valueIndicatorTextStyle:
            CommonTextStyles.getMediumTextStyleLight(context).copyWith(
          fontSize: 10,
        ),
        thumbColor: CommonColors.grayColor,
      ),
      child: Slider(
          label: '${_currentValue.round()} players',
          min: 0,
          max: 100,
          value: Provider.of<SliderValueNotifier>(context).currentValue,
          onChanged: (value) {
            Provider.of<SliderValueNotifier>(context, listen: false).changeValue(value);
          }),
    );
  }
}


class SliderValueNotifier extends ChangeNotifier {
  double _currentValue = 20;
  void changeValue(double value) {
    _currentValue = value;
    notifyListeners();
  }
  double get currentValue => _currentValue;
}
