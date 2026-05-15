import 'package:flutter/foundation.dart';
import '../models/mood_entry.dart';
import '../services/mood_storage_service.dart';

class MoodController {
  static const int maxEntries = 7;

  final ValueNotifier<List<MoodEntry>> entries = ValueNotifier<List<MoodEntry>>(
    <MoodEntry>[],
  );

  final MoodStorageService _storageService = MoodStorageService();
  final bool enablePersistence;
  bool _isInitialized = false;

  MoodController({this.enablePersistence = true});

  // Load saved mood entries from storage
  Future<void> loadEntries() async {
    if (_isInitialized) return;

    // Skip loading if persistence is disabled
    if (!enablePersistence) {
      _isInitialized = true;
      return;
    }

    try {
      final loadedEntries = await _storageService.loadMoodEntries();

      // Keep only the last maxEntries items
      if (loadedEntries.length > maxEntries) {
        final recentEntries = loadedEntries.sublist(
          loadedEntries.length - maxEntries,
        );
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
    // Skip saving if persistence is disabled
    if (!enablePersistence) return;

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

    // Only clear storage if persistence is enabled
    if (enablePersistence) {
      await _storageService.clearMoodEntries();
    }
  }

  void dispose() {
    try {
      entries.dispose();
    } catch (e) {
      debugPrint('Error disposing controller: $e');
    }
  }
}
