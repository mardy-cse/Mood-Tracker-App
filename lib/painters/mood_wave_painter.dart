import 'package:flutter/material.dart';

class MoodWavePainter extends CustomPainter {
  final Color color;
  final double heightFraction;

  const MoodWavePainter({required this.color, this.heightFraction = 0.38});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = size.height * heightFraction;

    path.lineTo(0, waveHeight - 40);
    path.cubicTo(
      size.width * 0.25,
      waveHeight + 30,
      size.width * 0.75,
      waveHeight - 60,
      size.width,
      waveHeight,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MoodWavePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.heightFraction != heightFraction;
  }
}
