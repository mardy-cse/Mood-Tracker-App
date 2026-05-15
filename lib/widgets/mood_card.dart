import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../painters/mood_face_painter.dart';

class MoodCard extends StatelessWidget {
  final MoodEntry entry;
  final VoidCallback onDelete;

  const MoodCard({super.key, required this.entry, required this.onDelete});

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    return '$day/$month/${dt.year}  $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final mood = entry.mood;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: mood.color.withAlpha(80), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: mood.color.withAlpha(30),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: mood.lightColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomPaint(
                painter: MoodFacePainter(
                  smileValue: mood.smileValue,
                  faceColor: mood.lightColor,
                  strokeColor: mood.color,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      mood.label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: mood.color,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatTime(entry.timestamp),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                if (entry.note != null && entry.note!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    entry.note!,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              Icons.close_rounded,
              size: 18,
              color: Colors.grey.shade400,
            ),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey.shade100,
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
