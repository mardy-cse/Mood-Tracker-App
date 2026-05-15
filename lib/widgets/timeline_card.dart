import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_decorations.dart';
import '../constants/app_text_styles.dart';

class TimelineCard extends StatelessWidget {
  final Widget child;

  const TimelineCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: AppDecorations.borderRadiusXLarge,
        boxShadow: AppDecorations.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeader(), const SizedBox(height: 20), child],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: AppDecorations.iconBackground(AppColors.timelineIcon),
          child: const Icon(
            Icons.history_rounded,
            size: 20,
            color: AppColors.timelineIcon,
          ),
        ),
        const SizedBox(width: 12),
        Text('Your Mood Timeline', style: AppTextStyles.cardTitle),
      ],
    );
  }
}
