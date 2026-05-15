import 'package:flutter/material.dart';

enum MoodType { happy, neutral, sad }

class MoodEntry {
  final DateTime date;
  final MoodType moodType;
  final Color moodColor;

  const MoodEntry({
    required this.date,
    required this.moodType,
    required this.moodColor,
  });
}
