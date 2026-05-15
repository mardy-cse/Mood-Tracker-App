import 'package:flutter/material.dart';
import '../controllers/mood_controller.dart';
import '../models/mood_entry.dart';
import '../painters/mood_wave_painter.dart';
import '../widgets/mood_selector.dart';
import '../widgets/mood_history_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MoodController _controller = MoodController();
  final TextEditingController _noteController = TextEditingController();

  static const _headerColor = Color(0xFF6C63FF);

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _onLogMood() {
    final logged = _controller.logMood();
    if (!logged) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a mood first.'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    _noteController.clear();
  }

  Color _waveColor(MoodLevel? mood) {
    if (mood == null) return _headerColor;
    return Color.lerp(_headerColor, mood.color, 0.55)!;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final selectedMood = _controller.selectedMood;
        final waveColor = _waveColor(selectedMood);

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          body: Column(
            children: [
              // ── Header ──────────────────────────────────────────────
              SizedBox(
                height: 260,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedCustomPaint(color: waveColor),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Mood Tracker',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'How are you feeling today?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(210),
                              ),
                            ),
                            const SizedBox(height: 28),
                            MoodSelector(
                              selectedMood: selectedMood,
                              onMoodSelected: _controller.selectMood,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Note + Log button ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _noteController,
                        onChanged: _controller.updateNote,
                        decoration: InputDecoration(
                          hintText: 'Add a note… (optional)',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: waveColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      decoration: BoxDecoration(
                        color: waveColor,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: waveColor.withAlpha(100),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _onLogMood,
                          borderRadius: BorderRadius.circular(14),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            child: Text(
                              'Log',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section label ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    Text(
                      'History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: waveColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_controller.entries.length}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: waveColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Mood history list ────────────────────────────────────
              Expanded(
                child: MoodHistoryList(
                  entries: _controller.entries,
                  onDelete: _controller.removeEntry,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Animates the custom painter color smoothly on mood change
class AnimatedCustomPaint extends ImplicitlyAnimatedWidget {
  final Color color;

  const AnimatedCustomPaint({
    super.key,
    required this.color,
    super.duration = const Duration(milliseconds: 350),
    super.curve = Curves.easeOut,
  });

  @override
  AnimatedWidgetBaseState<AnimatedCustomPaint> createState() =>
      _AnimatedCustomPaintState();
}

class _AnimatedCustomPaintState
    extends AnimatedWidgetBaseState<AnimatedCustomPaint> {
  ColorTween? _colorTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _colorTween =
        visitor(
              _colorTween,
              widget.color,
              (value) => ColorTween(begin: value as Color),
            )
            as ColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorTween?.evaluate(animation) ?? widget.color;
    return CustomPaint(painter: _WavePainterAdapter(color: color));
  }
}

class _WavePainterAdapter extends CustomPainter {
  final Color color;
  _WavePainterAdapter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const MoodWavePainter(color: Colors.transparent).paint(canvas, size);
    // Draw fill with animated color
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = size.height * 0.78;

    path.lineTo(0, waveHeight - 40);
    path.cubicTo(
      size.width * 0.25,
      waveHeight + 30,
      size.width * 0.75,
      waveHeight - 60,
      size.width,
      waveHeight,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_WavePainterAdapter old) => old.color != color;
}
