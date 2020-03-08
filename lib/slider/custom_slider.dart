import 'package:custom_slider/common_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_colors.dart';

class CustomSlider extends StatelessWidget {
  final double _trackHeight = 10.0;

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
          label: '${Provider.of<SliderValueNotifier>(context).currentValue.round()} players',
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
