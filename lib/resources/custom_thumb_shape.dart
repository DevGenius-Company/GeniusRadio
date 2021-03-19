import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomThumbShape extends SliderComponentShape {

  final double thumbRadius;

  const CustomThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center, {Animation<double> activationAnimation, Animation<double> enableAnimation, bool isDiscrete, TextPainter labelPainter, RenderBox parentBox, SliderThemeData sliderTheme, TextDirection textDirection, double value, double textScaleFactor, Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = sliderTheme.thumbColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final Path shadowPath = Path()
      ..addArc(Rect.fromCenter(center: center, width: 2 * thumbRadius, height: 2 * thumbRadius), 0, math.pi * 2);

    canvas.drawShadow(shadowPath, Colors.black, 5, true);

    canvas.drawCircle(center, thumbRadius, borderPaint);
    canvas.drawCircle(center, thumbRadius, fillPaint);
  }
}