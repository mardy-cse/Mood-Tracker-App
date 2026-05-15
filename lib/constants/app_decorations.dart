import 'package:flutter/material.dart';

class AppDecorations {
  AppDecorations._();

  // Border Radius
  static BorderRadius borderRadiusSmall = BorderRadius.circular(10);
  static BorderRadius borderRadiusMedium = BorderRadius.circular(16);
  static BorderRadius borderRadiusLarge = BorderRadius.circular(18);
  static BorderRadius borderRadiusXLarge = BorderRadius.circular(20);

  // Card Shadow
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 20,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  // Button Shadow
  static List<BoxShadow> buttonShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.3),
      blurRadius: 12,
      offset: const Offset(0, 6),
      spreadRadius: 0,
    ),
  ];

  // Timeline Item Shadow
  static List<BoxShadow> timelineItemShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.15),
      blurRadius: 10,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  // Face Container Shadow
  static List<BoxShadow> faceContainerShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.2),
      blurRadius: 12,
      offset: const Offset(0, 3),
      spreadRadius: 0,
    ),
  ];

  // Mood Indicator Shadow
  static List<BoxShadow> moodIndicatorShadow(Color color) => [
    BoxShadow(color: color.withOpacity(0.4), blurRadius: 4, spreadRadius: 1),
  ];

  // Button Gradient
  static LinearGradient buttonGradient(Color color) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [color, color.withOpacity(0.8)],
  );

  // Timeline Item Gradient
  static LinearGradient timelineItemGradient(Color color) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [color.withOpacity(0.08), color.withOpacity(0.15)],
  );

  // Empty State Gradient
  static LinearGradient emptyStateGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.grey.shade50, Colors.grey.shade100],
  );

  // Icon Background Decoration
  static BoxDecoration iconBackground(Color color) => BoxDecoration(
    color: color.withOpacity(0.1),
    borderRadius: borderRadiusSmall,
  );
}
