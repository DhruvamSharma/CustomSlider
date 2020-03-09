import 'dart:math';

import 'package:flutter/material.dart';

class CustomTrackShape extends SliderTrackShape {
  final double maxPlayers;
  final double defaultPlayers;
  final double minPlayers;

  final double currentPosition;
  double trackWidth;

  CustomTrackShape({
    @required this.maxPlayers,
    @required this.defaultPlayers,
    @required this.minPlayers,
    @required this.currentPosition,
  });

  @override
  Rect getPreferredRect(
      {RenderBox parentBox,
      Offset offset = Offset.zero,
      SliderThemeData sliderTheme,
      bool isEnabled,
      bool isDiscrete}) {
    final double thumbWidth = sliderTheme.thumbShape
        .getPreferredSize(
          isEnabled,
          isDiscrete,
        )
        .width;
    final double trackHeight = sliderTheme.trackHeight;
    assert(thumbWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= thumbWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackLeft = offset.dx + thumbWidth / 2;
    trackWidth = parentBox.size.width - thumbWidth;

    return Rect.fromLTWH(
      trackLeft,
      trackTop,
      trackWidth,
      trackHeight,
    );
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
    // Check for slider track height
    if (sliderTheme.trackHeight == 0) return;
    // Get the rect that we just calculated
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Calculate the width for which the default players
    // will be covered on the slider track shape
    double defaultPlayerWidth = (trackWidth / maxPlayers) * defaultPlayers;
    double currentPositionWidth = (trackWidth / maxPlayers) * currentPosition;

    // calculating the paint
    // for the default path (initial width)
    final Paint defaultPathPaint = Paint()
      ..color = sliderTheme.activeTrackColor
      ..style = PaintingStyle.fill;

    // calculate the path segment for
    // the default width
    final defaultPathSegment = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(trackRect.left, trackRect.top),
          Offset(
              trackRect.left +
                  (currentPositionWidth >= defaultPlayerWidth
                      ? defaultPlayerWidth
                      : currentPositionWidth),
              trackRect.bottom),
        ),
      )
      ..lineTo(trackRect.left, trackRect.bottom)
      ..arcTo(
        Rect.fromPoints(
          Offset(trackRect.left + 5, trackRect.top),
          Offset(trackRect.left - 5, trackRect.bottom),
        ),
        -pi * 3 / 2,
        pi,
        false,
      );

    context.canvas.drawPath(defaultPathSegment, defaultPathPaint);
  }
}
