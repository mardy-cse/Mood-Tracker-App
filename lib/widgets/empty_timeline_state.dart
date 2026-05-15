import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_decorations.dart';
import '../constants/app_text_styles.dart';

class EmptyTimelineState extends StatelessWidget {
  const EmptyTimelineState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: AppDecorations.emptyStateGradient,
        borderRadius: AppDecorations.borderRadiusLarge,
        border: Border.all(color: AppColors.emptyStateBorder, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sentiment_satisfied_alt_outlined,
            size: 36,
            color: AppColors.emptyStateIcon,
          ),
          const SizedBox(height: 10),
          Text(
            'Start tracking your mood!',
            style: AppTextStyles.emptyStateTitle,
          ),
          const SizedBox(height: 4),
          Text(
            'Tap a button above to log your first mood',
            style: AppTextStyles.emptyStateSubtitle,
          ),
        ],
      ),
    );
  }
}
