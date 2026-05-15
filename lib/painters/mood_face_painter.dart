import 'package:flutter/material.dart';
import 'dart:math' as math;

class MoodFacePainter extends CustomPainter {
  final double smileValue;
  final Color faceColor;
  final Color strokeColor;

  const MoodFacePainter({
    required this.smileValue,
    required this.faceColor,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final strokeWidth = radius * 0.12;

    final fillPaint = Paint()
      ..color = faceColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, fillPaint);

    final eyeY = center.dy - radius * 0.22;
    final eyeOffsetX = radius * 0.28;
    final eyeRadius = radius * 0.10;
    canvas.drawCircle(
      Offset(center.dx - eyeOffsetX, eyeY),
      eyeRadius,
      strokePaint..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      Offset(center.dx + eyeOffsetX, eyeY),
      eyeRadius,
      strokePaint..style = PaintingStyle.fill,
    );

    strokePaint.style = PaintingStyle.stroke;

    final mouthY = center.dy + radius * 0.20;
    final mouthHalfWidth = radius * 0.36;
    final curveDrop = radius * 0.28 * smileValue;

    final mouthPath = Path()
      ..moveTo(center.dx - mouthHalfWidth, mouthY)
      ..cubicTo(
        center.dx - mouthHalfWidth,
        mouthY + curveDrop * 1.5,
        center.dx + mouthHalfWidth,
        mouthY + curveDrop * 1.5,
        center.dx + mouthHalfWidth,
        mouthY,
      );
    canvas.drawPath(mouthPath, strokePaint);
  }

  @override
  bool shouldRepaint(MoodFacePainter old) =>
      old.smileValue != smileValue ||
      old.faceColor != faceColor ||
      old.strokeColor != strokeColor;
}
