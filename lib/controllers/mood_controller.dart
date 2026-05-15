import 'package:flutter/foundation.dart';
import '../models/mood_entry.dart';
import '../services/mood_storage_service.dart';

class MoodController {
  static const int maxEntries = 7;

  final ValueNotifier<List<MoodEntry>> entries = ValueNotifier<List<MoodEntry>>(
    <MoodEntry>[],
  );

  final MoodStorageService _storageService = MoodStorageService();
  bool _isInitialized = false;

  // Load saved mood entries from storage
  Future<void> loadEntries() async {
    if (_isInitialized) return;

    try {
      final loadedEntries = await _storageService.loadMoodEntries();
      
      // Keep only the last maxEntries items
      if (loadedEntries.length > maxEntries) {
        final recentEntries = loadedEntries.sublist(loadedEntries.length - maxEntries);
        entries.value = List<MoodEntry>.unmodifiable(recentEntries);
      } else {
        entries.value = List<MoodEntry>.unmodifiable(loadedEntries);
      }
      
      _isInitialized = true;
    } catch (e) {
      debugPrint('Error loading mood entries: $e');
      _isInitialized = true;
    }
  }

  // Save mood entries to storage
  Future<void> _saveEntries() async {
    try {
      await _storageService.saveMoodEntries(entries.value);
    } catch (e) {
      debugPrint('Error saving mood entries: $e');
    }
  }

  void addMoodEntry(MoodEntry? entry) {
    if (entry == null) return;

    try {
      final updated = List<MoodEntry>.from(entries.value)..add(entry);

      if (updated.length > maxEntries) {
        updated.removeAt(0);
      }

      entries.value = List<MoodEntry>.unmodifiable(updated);
      
      // Save to persistent storage
      _saveEntries();
    } catch (e) {
      debugPrint('Error adding mood entry: $e');
    }
  }

  Future<void> clear() async {
    entries.value = <MoodEntry>[];
    await _storageService.clearMoodEntries();
  }

  void dispose() {
    try {
      entries.dispose();
    } catch (e) {
      debugPrint('Error disposing controller: $e');
    }
  }
}
