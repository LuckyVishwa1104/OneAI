import 'package:flutter/material.dart';

class AnimatedAiIcon extends StatefulWidget {
  final double iconSize;
  const AnimatedAiIcon({super.key, this.iconSize = 30});

  @override
  State<AnimatedAiIcon> createState() => _AnimatedAiIconState();
}

class _AnimatedAiIconState extends State<AnimatedAiIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _startAnimationLoop();
  }

  Future<void> _startAnimationLoop() async {
    while (mounted) {
      await _controller.forward(from: 0);

      // Pause before replaying
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = _controller.value;

        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFF7C3AED), // purple
                Color(0xFF06B6D4), // cyan
                Color(0xFF3B82F6), // blue
                Color(0xFF8B5CF6), // violet
              ],
              stops: [
                (value - 0.3).clamp(0.0, 1.0),
                value.clamp(0.0, 1.0),
                (value + 0.3).clamp(0.0, 1.0),
                1.0,
              ],
            ).createShader(bounds);
          },
          child: Icon(
            Icons.auto_awesome,
            size: widget.iconSize,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
