import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../controllers/mood_controller.dart';
import '../models/mood_entry.dart';
import '../widgets/header_section.dart';
import '../widgets/mood_button.dart';
import '../widgets/mood_timeline_widget.dart';
import '../widgets/timeline_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MoodController _controller = MoodController();

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  void _disposeController() {
    try {
      _controller.dispose();
    } catch (e) {
      debugPrint('Error disposing controller: $e');
    }
  }

  void _addMood(MoodType moodType) {
    try {
      _controller.addMoodEntry(
        MoodEntry(
          date: DateTime.now(),
          moodType: moodType,
          moodColor: AppColors.getMoodColor(moodType),
        ),
      );
    } catch (e) {
      debugPrint('Error adding mood: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(),
              const SizedBox(height: 32),
              _buildMoodButtons(),
              const SizedBox(height: 48),
              TimelineCard(child: _buildTimelineContent()),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButtons() {
    return Row(
      children: [
        MoodButton(
          moodType: MoodType.happy,
          onPressed: () => _addMood(MoodType.happy),
        ),
        MoodButton(
          moodType: MoodType.neutral,
          onPressed: () => _addMood(MoodType.neutral),
        ),
        MoodButton(
          moodType: MoodType.sad,
          onPressed: () => _addMood(MoodType.sad),
        ),
      ],
    );
  }

  Widget _buildTimelineContent() {
    return ValueListenableBuilder<List<MoodEntry>>(
      valueListenable: _controller.entries,
      builder: (context, entries, _) {
        try {
          return MoodTimelineWidget(entries: entries);
        } catch (e) {
          debugPrint('Error building timeline: $e');
          return _buildErrorState();
        }
      },
    );
  }

  Widget _buildErrorState() {
    return Container(
      height: 140,
      alignment: Alignment.center,
      child: Text(
        'Unable to load mood timeline',
        style: AppTextStyles.emptyStateSubtitle,
      ),
    );
  }
}
