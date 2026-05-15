import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../painters/happy_face_painter.dart';
import '../painters/neutral_face_painter.dart';
import '../painters/sad_face_painter.dart';

class MoodFaceWidget extends StatelessWidget {
  final MoodType moodType;
  final Color faceColor;
  final Color strokeColor;

  const MoodFaceWidget({
    super.key,
    required this.moodType,
    this.faceColor = Colors.white,
    required this.strokeColor,
  });

  CustomPainter _getPainter() {
    switch (moodType) {
      case MoodType.happy:
        return HappyFacePainter(faceColor: faceColor, strokeColor: strokeColor);
      case MoodType.neutral:
        return NeutralFacePainter(
          faceColor: faceColor,
          strokeColor: strokeColor,
        );
      case MoodType.sad:
        return SadFacePainter(faceColor: faceColor, strokeColor: strokeColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _getPainter(), child: const SizedBox.expand());
  }
}
