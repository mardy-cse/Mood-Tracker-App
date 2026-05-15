import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_decorations.dart';
import '../constants/app_text_styles.dart';
import '../models/mood_entry.dart';

class MoodButton extends StatelessWidget {
  final MoodType moodType;
  final VoidCallback onPressed;

  const MoodButton({
    super.key,
    required this.moodType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getMoodColor(moodType);
    final label = AppColors.getMoodLabel(moodType);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: AppDecorations.borderRadiusMedium,
            child: Ink(
              decoration: BoxDecoration(
                gradient: AppDecorations.buttonGradient(color),
                borderRadius: AppDecorations.borderRadiusMedium,
                boxShadow: AppDecorations.buttonShadow(color),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Text(label, style: AppTextStyles.button),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
