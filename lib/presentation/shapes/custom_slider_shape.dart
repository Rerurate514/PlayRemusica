import 'package:flutter/material.dart';

class CustomSliderShape extends SliderComponentShape {
  final double thumbRadius;
  final double thumbWidth;
  final String label;

  const CustomSliderShape({
    this.thumbRadius = 12.0,
    this.thumbWidth = 32.0,
    this.label = '',
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbRadius * 2);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Paint thumbPaint = Paint()
      ..color = colorTween.evaluate(enableAnimation) ?? Colors.grey;

    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: thumbWidth,
        height: thumbRadius * 2,
      ),
      Radius.circular(thumbRadius / 2),
    );

    canvas.drawRRect(rect, thumbPaint);

    final TextSpan span = TextSpan(
      style: TextStyle(
        color: sliderTheme.valueIndicatorTextStyle?.color ?? Colors.white,
        fontSize: thumbRadius * 1.2,
        fontWeight: FontWeight.bold,
      ),
      text: label,
    );

    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();

    final Offset textOffset = Offset(
      center.dx - tp.width / 2,
      center.dy - tp.height / 2,
    );

    tp.paint(canvas, textOffset);
  }
}
