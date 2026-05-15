import 'package:flutter/material.dart';
import 'dart:math' as math;

class NeutralFacePainter extends CustomPainter {
  final Color faceColor;
  final Color strokeColor;

  const NeutralFacePainter({
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

    final eyeY = center.dy - radius * 0.25;
    final eyeOffsetX = radius * 0.3;
    final eyeRadius = radius * 0.11;
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

    final mouthY = center.dy + radius * 0.25;
    final mouthHalfWidth = radius * 0.35;
    final mouthPath = Path()
      ..moveTo(center.dx - mouthHalfWidth, mouthY)
      ..lineTo(center.dx + mouthHalfWidth, mouthY);
    canvas.drawPath(mouthPath, strokePaint);
  }

  @override
  bool shouldRepaint(NeutralFacePainter old) =>
      old.faceColor != faceColor || old.strokeColor != strokeColor;
}
