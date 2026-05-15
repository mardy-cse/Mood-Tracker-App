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

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'moodType': moodType.name,
      'moodColorValue':
          (moodColor.a * 255).toInt() << 24 |
          (moodColor.r * 255).toInt() << 16 |
          (moodColor.g * 255).toInt() << 8 |
          (moodColor.b * 255).toInt(),
    };
  }

  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      date: DateTime.parse(json['date'] as String),
      moodType: MoodType.values.firstWhere(
        (e) => e.name == json['moodType'],
        orElse: () => MoodType.neutral,
      ),
      moodColor: Color(json['moodColorValue'] as int),
    );
  }
}
