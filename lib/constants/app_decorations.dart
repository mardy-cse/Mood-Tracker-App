import 'package:flutter/material.dart';

class AppDecorations {
  AppDecorations._();

  static BorderRadius borderRadiusSmall = BorderRadius.circular(10);
  static BorderRadius borderRadiusMedium = BorderRadius.circular(16);
  static BorderRadius borderRadiusLarge = BorderRadius.circular(18);
  static BorderRadius borderRadiusXLarge = BorderRadius.circular(20);

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withAlpha(10),
      blurRadius: 20,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> buttonShadow(Color color) => [
    BoxShadow(
      color: color.withAlpha(77),
      blurRadius: 12,
      offset: const Offset(0, 6),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> timelineItemShadow(Color color) => [
    BoxShadow(
      color: color.withAlpha(38),
      blurRadius: 10,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> faceContainerShadow(Color color) => [
    BoxShadow(
      color: color.withAlpha(51),
      blurRadius: 12,
      offset: const Offset(0, 3),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> moodIndicatorShadow(Color color) => [
    BoxShadow(color: color.withAlpha(102), blurRadius: 4, spreadRadius: 1),
  ];

  static LinearGradient buttonGradient(Color color) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [color, color.withAlpha(204)],
  );

  static LinearGradient timelineItemGradient(Color color) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [color.withAlpha(20), color.withAlpha(38)],
  );

  static LinearGradient emptyStateGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.grey.shade50, Colors.grey.shade100],
  );

  static BoxDecoration iconBackground(Color color) => BoxDecoration(
    color: color.withAlpha(26),
    borderRadius: borderRadiusSmall,
  );
}
