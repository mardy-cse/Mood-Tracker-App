import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import 'mood_card.dart';

class MoodHistoryList extends StatelessWidget {
  final List<MoodEntry> entries;
  final ValueChanged<String> onDelete;

  const MoodHistoryList({
    super.key,
    required this.entries,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🌿', style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(
              'No moods logged yet.\nTap a mood above to get started!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                height: 1.6,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return MoodCard(
          key: ValueKey(entry.id),
          entry: entry,
          onDelete: () => onDelete(entry.id),
        );
      },
    );
  }
}
