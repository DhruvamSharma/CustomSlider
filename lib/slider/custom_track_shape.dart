import 'dart:math';

import 'package:custom_slider/common_colors.dart';
import 'package:flutter/material.dart';

class CustomTrackShape extends SliderTrackShape {
  final double maxPlayers;
  final double defaultPlayers;
  final double minPlayers;
  final double selectedPathBarWidth;
  final double currentPosition;
  double trackWidth;

  CustomTrackShape({
    @required this.maxPlayers,
    @required this.defaultPlayers,
    @required this.minPlayers,
    @required this.currentPosition,
    this.selectedPathBarWidth = 3,
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

    //calculate the paint for the path segment
    // that is unselected (inactive track)
    final unselectedPathPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = sliderTheme.inactiveTrackColor;

    final unselectedPathSegment = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(trackRect.right, trackRect.top),
          Offset(
            trackRect.left + currentPositionWidth,
            trackRect.bottom,
          ),
        ),
      )
      ..addArc(
        Rect.fromPoints(
          Offset(trackRect.right - 5, trackRect.bottom),
          Offset(trackRect.right + 5, trackRect.top),
        ),
        -pi / 2,
        pi,
      );

    context.canvas.drawPath(unselectedPathSegment, unselectedPathPaint);

    // Calculation for the selected part of the slider track
    // other than the default width
    final double selectedPathWidth = currentPositionWidth - defaultPlayerWidth;

    for (int i = 0;
        i < (selectedPathWidth / selectedPathBarWidth).round();
        i++) {
      paintCustomSelectedPath(
        defaultPlayerWidth,
        trackRect,
        currentPositionWidth,
        context,
        i,
        sliderTheme,
      );
    }
  }

  /// This method paints the selected path in our
  /// required style
  void paintCustomSelectedPath(
    double defaultPlayerWidth,
    Rect trackRect,
    double currentPositionWidth,
    PaintingContext context,
    int index,
    SliderThemeData sliderTheme,
  ) {
    // Selected Path
    final Paint borderPaint = Paint()
      ..color = index % 2 == 0 ? Colors.white : sliderTheme.activeTrackColor
      ..style = PaintingStyle.fill;

    final pathSegmentSelected = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(
            trackRect.left +
                defaultPlayerWidth +
                (selectedPathBarWidth * index),
            trackRect.top,
          ),
          Offset(
            trackRect.left +
                defaultPlayerWidth +
                (selectedPathBarWidth * index) +
                selectedPathBarWidth,
            trackRect.bottom,
          ),
        ),
      );

    context.canvas.drawPath(pathSegmentSelected, borderPaint);
  }
}
