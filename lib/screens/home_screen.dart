import 'package:flutter/material.dart';
import '../controllers/mood_controller.dart';
import '../models/mood_entry.dart';
import '../painters/mood_face_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MoodController _controller = MoodController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addMood(MoodType moodType) {
    final moodColor = _moodColor(moodType);
    _controller.addMoodEntry(
      MoodEntry(date: DateTime.now(), moodType: moodType, moodColor: moodColor),
    );
  }

  Color _moodColor(MoodType moodType) {
    switch (moodType) {
      case MoodType.happy:
        return const Color(0xFF4CAF50);
      case MoodType.neutral:
        return const Color(0xFF2196F3);
      case MoodType.sad:
        return const Color(0xFF7C4DFF);
    }
  }

  double _smileValue(MoodType moodType) {
    switch (moodType) {
      case MoodType.happy:
        return 1.0;
      case MoodType.neutral:
        return 0.0;
      case MoodType.sad:
        return -1.0;
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month';
  }

  Widget _moodButton({required MoodType moodType, required String label}) {
    final color = _moodColor(moodType);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: ElevatedButton(
          onPressed: () => _addMood(moodType),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'How are you feeling today?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E2A32),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _moodButton(moodType: MoodType.happy, label: 'Happy'),
                  _moodButton(moodType: MoodType.neutral, label: 'Neutral'),
                  _moodButton(moodType: MoodType.sad, label: 'Sad'),
                ],
              ),
              const SizedBox(height: 36),
              Text(
                'Last 7 moods',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<List<MoodEntry>>(
                valueListenable: _controller.entries,
                builder: (context, entries, _) {
                  if (entries.isEmpty) {
                    return Container(
                      height: 128,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE8ECF2)),
                      ),
                      child: Text(
                        'No mood logged yet',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }

                  final recent = entries.reversed.toList();
                  return SizedBox(
                    height: 128,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: recent.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final entry = recent[index];
                        return Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: entry.moodColor.withAlpha(100),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: entry.moodColor.withAlpha(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CustomPaint(
                                    painter: MoodFacePainter(
                                      smileValue: _smileValue(entry.moodType),
                                      faceColor: Colors.white,
                                      strokeColor: entry.moodColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: entry.moodColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _formatDate(entry.date),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
