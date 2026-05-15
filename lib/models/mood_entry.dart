import 'package:flutter/material.dart';

enum MoodLevel { happy, neutral, sad }

extension MoodLevelExtension on MoodLevel {
  String get label {
    switch (this) {
      case MoodLevel.happy:
        return 'Happy';
      case MoodLevel.neutral:
        return 'Neutral';
      case MoodLevel.sad:
        return 'Sad';
    }
  }

  Color get color {
    switch (this) {
      case MoodLevel.happy:
        return const Color(0xFF4CAF50);
      case MoodLevel.neutral:
        return const Color(0xFF2196F3);
      case MoodLevel.sad:
        return const Color(0xFF7C4DFF);
    }
  }

  Color get lightColor {
    switch (this) {
      case MoodLevel.happy:
        return const Color(0xFFE8F5E9);
      case MoodLevel.neutral:
        return const Color(0xFFE3F2FD);
      case MoodLevel.sad:
        return const Color(0xFFEDE7F6);
    }
  }

  /// Normalized smile value for CustomPainter face rendering.
  /// Range: 1.0 (full smile) → 0.0 (flat) → -1.0 (frown).
  double get smileValue {
    switch (this) {
      case MoodLevel.happy:
        return 1.0;
      case MoodLevel.neutral:
        return 0.0;
      case MoodLevel.sad:
        return -1.0;
    }
  }
}

class MoodEntry {
  final String id;
  final MoodLevel mood;
  final String? note;
  final DateTime timestamp;

  const MoodEntry({
    required this.id,
    required this.mood,
    this.note,
    required this.timestamp,
  });
}
