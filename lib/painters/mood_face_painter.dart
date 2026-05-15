import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Paints a simple smiley face whose expression is driven by [smileValue].
///
/// [smileValue] ranges from -1.0 (full frown) to 0.0 (flat) to 1.0 (full smile).
class MoodFacePainter extends CustomPainter {
  final double smileValue; // -1.0 → 0.0 → 1.0
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

    // Face circle
    canvas.drawCircle(center, radius, fillPaint);

    // Eyes
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

    // Mouth — cubic Bézier driven by smileValue
    final mouthY = center.dy + radius * 0.20;
    final mouthHalfWidth = radius * 0.36;
    final curveDrop =
        radius * 0.28 * smileValue; // positive = smile, negative = frown

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
