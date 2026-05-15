import 'package:flutter/material.dart';

class AppDecorations {
  AppDecorations._();

  static BorderRadius borderRadiusSmall = BorderRadius.circular(10);
  static BorderRadius borderRadiusMedium = BorderRadius.circular(16);
  static BorderRadius borderRadiusLarge = BorderRadius.circular(18);
  static BorderRadius borderRadiusXLarge = BorderRadius.circular(20);

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 20,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> buttonShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.3),
      blurRadius: 12,
      offset: const Offset(0, 6),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> timelineItemShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.15),
      blurRadius: 10,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> faceContainerShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.2),
      blurRadius: 12,
      offset: const Offset(0, 3),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> moodIndicatorShadow(Color color) => [
    BoxShadow(color: color.withOpacity(0.4), blurRadius: 4, spreadRadius: 1),
  ];

  static LinearGradient buttonGradient(Color color) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [color, color.withOpacity(0.8)],
  );

  static LinearGradient timelineItemGradient(Color color) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [color.withOpacity(0.08), color.withOpacity(0.15)],
  );

  static LinearGradient emptyStateGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.grey.shade50, Colors.grey.shade100],
  );

  static BoxDecoration iconBackground(Color color) => BoxDecoration(
    color: color.withOpacity(0.1),
    borderRadius: borderRadiusSmall,
  );
}
