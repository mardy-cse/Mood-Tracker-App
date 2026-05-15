import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle headerLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: Color(0xFF2C3E50),
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle subtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade600,
    letterSpacing: 0.2,
  );

  static const TextStyle button = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.grey.shade900,
    letterSpacing: -0.3,
  );

  static TextStyle emptyStateTitle = TextStyle(
    color: Colors.grey.shade700,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static TextStyle emptyStateSubtitle = TextStyle(
    color: Colors.grey.shade500,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle timelineDate = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );
}
