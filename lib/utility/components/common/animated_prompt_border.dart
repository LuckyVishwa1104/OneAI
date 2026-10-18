import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedPromptBorder extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final BorderRadius borderRadius;
  const AnimatedPromptBorder({
    super.key,
    required this.child,
    required this.enabled,
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
  });

  @override
  State<AnimatedPromptBorder> createState() => _AnimatedPromptBorderState();
}

class _AnimatedPromptBorderState extends State<AnimatedPromptBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedPromptBorder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.enabled && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.enabled && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _PromptBorderPainter(
            rotation: _controller.value * 2 * pi,
            borderRadius: widget.borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.5),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _PromptBorderPainter extends CustomPainter {
  final double rotation;
  final BorderRadius borderRadius;

  _PromptBorderPainter({
    required this.rotation,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final rrect = borderRadius.toRRect(rect);

    final shader = SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      transform: GradientRotation(rotation),
      colors: const [
        Colors.transparent,
        Colors.transparent,
        Color(0xFF7B3FF2),
        Color(0xFF4F6BFF),
        Colors.transparent,
        Colors.transparent,
      ],
      stops: const [
        0.00,
        0.38,
        0.48,
        0.54,
        0.64,
        1.00,
      ],
    ).createShader(rect);

    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _PromptBorderPainter oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}
