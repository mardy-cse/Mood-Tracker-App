import 'package:flutter/foundation.dart';
import '../models/mood_entry.dart';

class MoodController extends ChangeNotifier {
  final List<MoodEntry> _entries = [];
  MoodLevel? _selectedMood;
  String _noteText = '';

  List<MoodEntry> get entries => List.unmodifiable(_entries.reversed.toList());

  MoodLevel? get selectedMood => _selectedMood;
  String get noteText => _noteText;

  void selectMood(MoodLevel mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  void updateNote(String text) {
    _noteText = text;
  }

  bool logMood() {
    if (_selectedMood == null) return false;

    final entry = MoodEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      mood: _selectedMood!,
      note: _noteText.trim().isEmpty ? null : _noteText.trim(),
      timestamp: DateTime.now(),
    );

    _entries.add(entry);
    _selectedMood = null;
    _noteText = '';
    notifyListeners();
    return true;
  }

  void removeEntry(String id) {
    _entries.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
