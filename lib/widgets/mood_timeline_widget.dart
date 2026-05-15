import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import 'empty_timeline_state.dart';
import 'timeline_item.dart';

class MoodTimelineWidget extends StatelessWidget {
  final List<MoodEntry>? entries;

  const MoodTimelineWidget({super.key, this.entries});

  @override
  Widget build(BuildContext context) {
    final moodEntries = entries ?? [];

    if (moodEntries.isEmpty) {
      return const EmptyTimelineState();
    }

    return _buildTimelineList(context, moodEntries);
  }

  Widget _buildTimelineList(BuildContext context, List<MoodEntry> moodEntries) {
    final reversedEntries = moodEntries.reversed.toList();

    return SizedBox(
      height: 140,
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: reversedEntries.length,
          padding: const EdgeInsets.only(right: 12),
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (context, index) =>
              _buildTimelineItem(reversedEntries, index),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(List<MoodEntry> entries, int index) {
    if (index >= entries.length) return const SizedBox.shrink();

    final entry = entries[index];
    if (entry == null) return const SizedBox.shrink();

    return TimelineItem(entry: entry, formattedDate: _formatDate(entry.date));
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--/--';

    try {
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      return '$day/$month';
    } catch (e) {
      return '--/--';
    }
  }
}
