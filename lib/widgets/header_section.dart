import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          'How are you feeling today?',
          style: AppTextStyles.headerLarge,
        ),
        const SizedBox(height: 8),
        Text('Track your daily mood journey', style: AppTextStyles.subtitle),
      ],
    );
  }
}
