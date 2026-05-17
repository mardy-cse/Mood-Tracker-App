import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker_app/models/mood_entry.dart';
import 'package:mood_tracker_app/services/mood_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('MoodStorageService', () {
    late MoodStorageService storageService;

    setUp(() {
      storageService = MoodStorageService();
    });

    test('should save and load mood entries successfully', () async {
      SharedPreferences.setMockInitialValues({});

      final entries = [
        MoodEntry(
          date: DateTime(2026, 5, 17, 10, 30),
          moodType: MoodType.happy,
          moodColor: const Color(0xFF66BB6A),
        ),
        MoodEntry(
          date: DateTime(2026, 5, 16, 14, 20),
          moodType: MoodType.neutral,
          moodColor: const Color(0xFF42A5F5),
        ),
      ];

      final saved = await storageService.saveMoodEntries(entries);
      expect(saved, isTrue);

      final loaded = await storageService.loadMoodEntries();
      expect(loaded.length, 2);
      expect(loaded[0].moodType, MoodType.happy);
      expect(loaded[1].moodType, MoodType.neutral);
      expect(loaded[0].date, DateTime(2026, 5, 17, 10, 30));
    });

    test('should return empty list when no data stored', () async {
      SharedPreferences.setMockInitialValues({});

      final loaded = await storageService.loadMoodEntries();
      expect(loaded, isEmpty);
    });

    test('should clear mood entries successfully', () async {
      SharedPreferences.setMockInitialValues({});

      final entries = [
        MoodEntry(
          date: DateTime.now(),
          moodType: MoodType.sad,
          moodColor: const Color(0xFF9575CD),
        ),
      ];

      await storageService.saveMoodEntries(entries);

      var loaded = await storageService.loadMoodEntries();
      expect(loaded.length, 1);

      final cleared = await storageService.clearMoodEntries();
      expect(cleared, isTrue);

      loaded = await storageService.loadMoodEntries();
      expect(loaded, isEmpty);
    });

    test('should handle empty entries list', () async {
      SharedPreferences.setMockInitialValues({});

      final saved = await storageService.saveMoodEntries([]);
      expect(saved, isTrue);

      final loaded = await storageService.loadMoodEntries();
      expect(loaded, isEmpty);
    });

    test('should preserve mood entry data integrity', () async {
      SharedPreferences.setMockInitialValues({});

      final originalEntry = MoodEntry(
        date: DateTime(2026, 5, 17, 15, 45, 30),
        moodType: MoodType.neutral,
        moodColor: const Color(0xFF42A5F5),
      );

      await storageService.saveMoodEntries([originalEntry]);

      final loaded = await storageService.loadMoodEntries();
      final loadedEntry = loaded.first;

      expect(loadedEntry.moodType, originalEntry.moodType);
      expect(loadedEntry.moodColor.value, originalEntry.moodColor.value);
      expect(loadedEntry.date.year, originalEntry.date.year);
      expect(loadedEntry.date.month, originalEntry.date.month);
      expect(loadedEntry.date.day, originalEntry.date.day);
      expect(loadedEntry.date.hour, originalEntry.date.hour);
      expect(loadedEntry.date.minute, originalEntry.date.minute);
    });

    test('should handle multiple save operations', () async {
      SharedPreferences.setMockInitialValues({});

      final entries1 = [
        MoodEntry(
          date: DateTime(2026, 1, 1),
          moodType: MoodType.happy,
          moodColor: Colors.green,
        ),
      ];

      final entries2 = [
        MoodEntry(
          date: DateTime(2026, 1, 2),
          moodType: MoodType.sad,
          moodColor: Colors.purple,
        ),
        MoodEntry(
          date: DateTime(2026, 1, 3),
          moodType: MoodType.neutral,
          moodColor: Colors.blue,
        ),
      ];

      await storageService.saveMoodEntries(entries1);
      var loaded = await storageService.loadMoodEntries();
      expect(loaded.length, 1);

      await storageService.saveMoodEntries(entries2);
      loaded = await storageService.loadMoodEntries();
      expect(loaded.length, 2);
      expect(loaded[0].moodType, MoodType.sad);
    });

    test('should handle all mood types correctly', () async {
      SharedPreferences.setMockInitialValues({});

      final entries = [
        MoodEntry(
          date: DateTime.now(),
          moodType: MoodType.happy,
          moodColor: const Color(0xFF66BB6A),
        ),
        MoodEntry(
          date: DateTime.now(),
          moodType: MoodType.neutral,
          moodColor: const Color(0xFF42A5F5),
        ),
        MoodEntry(
          date: DateTime.now(),
          moodType: MoodType.sad,
          moodColor: const Color(0xFF9575CD),
        ),
      ];

      await storageService.saveMoodEntries(entries);
      final loaded = await storageService.loadMoodEntries();

      expect(loaded.length, 3);
      expect(loaded[0].moodType, MoodType.happy);
      expect(loaded[1].moodType, MoodType.neutral);
      expect(loaded[2].moodType, MoodType.sad);
    });
  });
}
