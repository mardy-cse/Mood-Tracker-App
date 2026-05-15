import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

const bool enableSharedPreferences = true;

void main() {
  runApp(const MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        fontFamily: 'sans-serif',
        useMaterial3: true,
      ),
      home: const HomeScreen(useSharedPreferences: enableSharedPreferences),
    );
  }
}
