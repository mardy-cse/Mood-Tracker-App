import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBackground = Colors.white;

  static const Color textPrimary = Color(0xFF2C3E50);
  static final Color textSecondary = Colors.grey.shade600;
  static final Color textDisabled = Colors.grey.shade500;

  static const Color moodHappy = Color(0xFF66BB6A);
  static const Color moodNeutral = Color(0xFF42A5F5);
  static const Color moodSad = Color(0xFF9575CD);

  static const Color timelineIcon = Color(0xFF42A5F5);

  static final Color emptyStateIcon = Colors.grey.shade400;
  static final Color emptyStateBg1 = Colors.grey.shade50;
  static final Color emptyStateBg2 = Colors.grey.shade100;
  static final Color emptyStateBorder = Colors.grey.shade200;
  static final Color emptyStateText = Colors.grey.shade700;

  static Color getMoodColor(MoodType moodType) {
    switch (moodType) {
      case MoodType.happy:
        return moodHappy;
      case MoodType.neutral:
        return moodNeutral;
      case MoodType.sad:
        return moodSad;
    }
  }

  static String getMoodLabel(MoodType moodType) {
    switch (moodType) {
      case MoodType.happy:
        return 'Happy';
      case MoodType.neutral:
        return 'Neutral';
      case MoodType.sad:
        return 'Sad';
    }
  }
}
