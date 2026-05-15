import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../painters/mood_face_painter.dart';

class MoodSelector extends StatelessWidget {
  final MoodLevel? selectedMood;
  final ValueChanged<MoodLevel> onMoodSelected;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: MoodLevel.values.map((mood) {
        final isSelected = selectedMood == mood;
        return GestureDetector(
          onTap: () => onMoodSelected(mood),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: isSelected ? 64 : 52,
            height: isSelected ? 64 : 52,
            decoration: BoxDecoration(
              color: isSelected ? mood.color : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: mood.color.withAlpha(isSelected ? 120 : 40),
                  blurRadius: isSelected ? 16 : 6,
                  spreadRadius: isSelected ? 2 : 0,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: isSelected ? mood.color : Colors.grey.shade200,
                width: isSelected ? 2.5 : 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomPaint(
                painter: MoodFacePainter(
                  smileValue: mood.smileValue,
                  faceColor: isSelected
                      ? Colors.white.withAlpha(230)
                      : mood.lightColor,
                  strokeColor: isSelected ? Colors.white : mood.color,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
