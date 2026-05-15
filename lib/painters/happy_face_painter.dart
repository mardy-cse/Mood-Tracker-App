import 'package:flutter/material.dart';
import 'dart:math' as math;

class HappyFacePainter extends CustomPainter {
  final Color faceColor;
  final Color strokeColor;

  const HappyFacePainter({required this.faceColor, required this.strokeColor});

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

    // Eyes (circles)
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

    // Happy smile using drawArc (upward curve)
    final mouthRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + radius * 0.15),
      width: radius * 0.8,
      height: radius * 0.6,
    );
    canvas.drawArc(mouthRect, 0, math.pi, false, strokePaint);
  }

  @override
  bool shouldRepaint(HappyFacePainter old) =>
      old.faceColor != faceColor || old.strokeColor != strokeColor;
}
