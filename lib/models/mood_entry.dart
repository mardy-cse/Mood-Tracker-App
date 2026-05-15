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

  // Convert MoodEntry to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'moodType': moodType.name,
      'moodColorValue': moodColor.value,
    };
  }

  // Create MoodEntry from JSON Map
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
