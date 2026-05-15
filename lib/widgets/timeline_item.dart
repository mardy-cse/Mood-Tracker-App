import 'package:flutter/material.dart';
import '../constants/app_decorations.dart';
import '../constants/app_text_styles.dart';
import '../models/mood_entry.dart';
import 'mood_face_widget.dart';

class TimelineItem extends StatefulWidget {
  final MoodEntry entry;
  final String formattedDate;

  const TimelineItem({
    super.key,
    required this.entry,
    required this.formattedDate,
  });

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _isPressed ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Container(
          width: 106,
          padding: const EdgeInsets.all(14),
          decoration: _buildDecoration(),
          child: _buildContent(),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    final color = widget.entry.moodColor;
    return BoxDecoration(
      gradient: AppDecorations.timelineItemGradient(color),
      borderRadius: AppDecorations.borderRadiusLarge,
      border: Border.all(color: color.withOpacity(0.25), width: 1.5),
      boxShadow: AppDecorations.timelineItemShadow(color),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFaceContainer(),
        const SizedBox(height: 10),
        _buildMoodIndicator(),
        const SizedBox(height: 8),
        _buildDateLabel(),
      ],
    );
  }

  Widget _buildFaceContainer() {
    final color = widget.entry.moodColor;
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: AppDecorations.faceContainerShadow(color),
      ),
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: MoodFaceWidget(
          moodType: widget.entry.moodType,
          strokeColor: color,
        ),
      ),
    );
  }

  Widget _buildMoodIndicator() {
    final color = widget.entry.moodColor;
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: AppDecorations.moodIndicatorShadow(color),
      ),
    );
  }

  Widget _buildDateLabel() {
    final color = widget.entry.moodColor;
    return Text(
      widget.formattedDate,
      style: AppTextStyles.timelineDate.copyWith(color: color.withOpacity(0.9)),
    );
  }
}
