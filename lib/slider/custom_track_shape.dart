import 'package:flutter/material.dart';

class CustomTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect(
      {RenderBox parentBox,
      Offset offset = Offset.zero,
      SliderThemeData sliderTheme,
      bool isEnabled,
      bool isDiscrete}) {

      final double thumbWidth = sliderTheme.thumbShape.getPreferredSize(isEnabled, isDiscrete,).width;
      final double trackHeight = sliderTheme.trackHeight;
      assert(thumbWidth >= 0);
      assert(trackHeight >= 0);
      assert(parentBox.size.width >= thumbWidth);
      assert(parentBox.size.height >= trackHeight);

      final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
      final double trackLeft = offset.dx + thumbWidth/2;
      final double trackWidth = parentBox.size.width - thumbWidth;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight,);
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {RenderBox parentBox,
      SliderThemeData sliderTheme,
      Animation<double> enableAnimation,
      Offset thumbCenter,
      bool isEnabled,
      bool isDiscrete,
      TextDirection textDirection}) {
    // TODO: implement paint
  }
}
