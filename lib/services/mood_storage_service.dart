import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_entry.dart';

class MoodStorageService {
  static const String _storageKey = 'mood_entries';

  Future<bool> saveMoodEntries(List<MoodEntry> entries) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = entries.map((entry) => entry.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      return await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      return false;
    }
  }

  Future<List<MoodEntry>> loadMoodEntries() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => MoodEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> clearMoodEntries() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_storageKey);
    } catch (e) {
      return false;
    }
  }
}
