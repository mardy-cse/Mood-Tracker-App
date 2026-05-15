import 'package:flutter/foundation.dart';
import '../models/mood_entry.dart';

class MoodController {
  static const int maxEntries = 7;

  final ValueNotifier<List<MoodEntry>> entries = ValueNotifier<List<MoodEntry>>(
    <MoodEntry>[],
  );

  void addMoodEntry(MoodEntry? entry) {
    if (entry == null) return;

    try {
      final updated = List<MoodEntry>.from(entries.value)..add(entry);

      if (updated.length > maxEntries) {
        updated.removeAt(0);
      }

      entries.value = List<MoodEntry>.unmodifiable(updated);
    } catch (e) {
      debugPrint('Error adding mood entry: $e');
    }
  }

  void clear() {
    entries.value = <MoodEntry>[];
  }

  void dispose() {
    try {
      entries.dispose();
    } catch (e) {
      debugPrint('Error disposing controller: $e');
    }
  }
}
