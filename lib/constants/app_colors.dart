import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class AppColors {
  AppColors._();

  // Background Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBackground = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static final Color textSecondary = Colors.grey.shade600;
  static final Color textDisabled = Colors.grey.shade500;

  // Mood Colors
  static const Color moodHappy = Color(0xFF66BB6A);
  static const Color moodNeutral = Color(0xFF42A5F5);
  static const Color moodSad = Color(0xFF9575CD);

  // Timeline Icon
  static const Color timelineIcon = Color(0xFF42A5F5);

  // Empty State
  static final Color emptyStateIcon = Colors.grey.shade400;
  static final Color emptyStateBg1 = Colors.grey.shade50;
  static final Color emptyStateBg2 = Colors.grey.shade100;
  static final Color emptyStateBorder = Colors.grey.shade200;
  static final Color emptyStateText = Colors.grey.shade700;

  // Helper method to get mood color
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

  // Helper method to get mood label
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
