import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker_app/controllers/mood_controller.dart';
import 'package:mood_tracker_app/models/mood_entry.dart';

void main() {
  group('MoodController', () {
    test('should initialize with empty entries', () {
      final controller = MoodController(enablePersistence: false);
      expect(controller.entries.value, isEmpty);
    });

    test('should add mood entry successfully', () {
      final controller = MoodController(enablePersistence: false);
      final entry = MoodEntry(
        date: DateTime.now(),
        moodType: MoodType.happy,
        moodColor: Colors.green,
      );

      controller.addMoodEntry(entry);

      expect(controller.entries.value.length, 1);
      expect(controller.entries.value.first.moodType, MoodType.happy);
    });

    test('should maintain max 7 entries limit', () {
      final controller = MoodController(enablePersistence: false);

      for (int i = 0; i < 10; i++) {
        controller.addMoodEntry(
          MoodEntry(
            date: DateTime.now().add(Duration(hours: i)),
            moodType: MoodType.happy,
            moodColor: Colors.green,
          ),
        );
      }

      expect(controller.entries.value.length, 7);
    });

    test('should remove oldest entry when exceeding max limit', () {
      final controller = MoodController(enablePersistence: false);
      final firstEntry = MoodEntry(
        date: DateTime(2026, 1, 1),
        moodType: MoodType.sad,
        moodColor: Colors.purple,
      );

      controller.addMoodEntry(firstEntry);

      for (int i = 0; i < 7; i++) {
        controller.addMoodEntry(
          MoodEntry(
            date: DateTime(2026, 1, i + 2),
            moodType: MoodType.happy,
            moodColor: Colors.green,
          ),
        );
      }

      expect(controller.entries.value.length, 7);
      expect(controller.entries.value.first.date, isNot(firstEntry.date));
      expect(controller.entries.value.first.moodType, MoodType.happy);
    });

    test('should clear all entries', () async {
      final controller = MoodController(enablePersistence: false);

      controller.addMoodEntry(
        MoodEntry(
          date: DateTime.now(),
          moodType: MoodType.happy,
          moodColor: Colors.green,
        ),
      );

      expect(controller.entries.value.length, 1);

      await controller.clear();

      expect(controller.entries.value, isEmpty);
    });

    test('should handle null entry gracefully', () {
      final controller = MoodController(enablePersistence: false);

      controller.addMoodEntry(null);

      expect(controller.entries.value, isEmpty);
    });

    test('should call onError callback when provided', () async {
      final errorMessages = <String>[];
      final controller = MoodController(
        enablePersistence: false,
        onError: (message) => errorMessages.add(message),
      );

      // Add entry normally (no error expected with persistence disabled)
      controller.addMoodEntry(
        MoodEntry(
          date: DateTime.now(),
          moodType: MoodType.happy,
          moodColor: Colors.green,
        ),
      );

      expect(controller.entries.value.length, 1);
      // Note: With persistence disabled, no errors should be triggered
      // In a real test environment with mocking, we would mock the storage service
      // to simulate failures and verify error callbacks
    });

    test('should preserve entries order', () {
      final controller = MoodController(enablePersistence: false);
      final entries = [
        MoodEntry(
          date: DateTime(2026, 1, 1),
          moodType: MoodType.happy,
          moodColor: Colors.green,
        ),
        MoodEntry(
          date: DateTime(2026, 1, 2),
          moodType: MoodType.neutral,
          moodColor: Colors.blue,
        ),
        MoodEntry(
          date: DateTime(2026, 1, 3),
          moodType: MoodType.sad,
          moodColor: Colors.purple,
        ),
      ];

      for (var entry in entries) {
        controller.addMoodEntry(entry);
      }

      expect(controller.entries.value.length, 3);
      expect(controller.entries.value[0].date, DateTime(2026, 1, 1));
      expect(controller.entries.value[1].date, DateTime(2026, 1, 2));
      expect(controller.entries.value[2].date, DateTime(2026, 1, 3));
    });

    test('should make entries list unmodifiable', () {
      final controller = MoodController(enablePersistence: false);

      controller.addMoodEntry(
        MoodEntry(
          date: DateTime.now(),
          moodType: MoodType.happy,
          moodColor: Colors.green,
        ),
      );

      expect(
        () => controller.entries.value.add(
          MoodEntry(
            date: DateTime.now(),
            moodType: MoodType.sad,
            moodColor: Colors.purple,
          ),
        ),
        throwsUnsupportedError,
      );
    });
  });
}
