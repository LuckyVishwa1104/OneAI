import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../constants/constant.dart';

/// A circular loading indicator with a linear-gradient background track
/// and a rotating arc (with a fading sweep-gradient trail) inside it —
/// visually similar to [CircularProgressIndicator]'s indeterminate mode.
class GradientCircularProgressIndicator extends StatefulWidget {
  const GradientCircularProgressIndicator({
    super.key,
    this.size = 48,
    this.strokeWidth = 4,
    this.sweepAngle = 90, // degrees covered by the moving arc
    this.duration = const Duration(milliseconds: 1200),
    this.indicatorColor,
    this.indicatorGradientColors,
  });

  final double size;
  final double strokeWidth;
  final double sweepAngle;
  final Duration duration;

  /// Solid color for the moving arc. Ignored if [indicatorGradientColors] is set.
  final Color? indicatorColor;

  /// Optional 2-color gradient for the moving arc (start -> end of the trail).
  final List<Color>? indicatorGradientColors;

  @override
  State<GradientCircularProgressIndicator> createState() =>
      _GradientCircularProgressIndicatorState();
}

class _GradientCircularProgressIndicatorState
    extends State<GradientCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColors = isDark
        ? [
            AppColors.gradientSubtleDarkStart,
            AppColors.gradientSubtleDarkEnd,
          ]
        : [
            AppColors.gradientSubtleLightStart,
            AppColors.gradientSubtleLightEnd,
          ];

    final baseIndicatorColor =
        widget.indicatorColor ?? Theme.of(context).colorScheme.primary;

    final indicatorColors = widget.indicatorGradientColors ??
        [baseIndicatorColor, baseIndicatorColor];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          size: Size.square(widget.size),
          painter: _GradientCircularProgressPainter(
            progress: _controller.value,
            strokeWidth: widget.strokeWidth,
            sweepAngleDegrees: widget.sweepAngle,
            backgroundColors: backgroundColors,
            indicatorColors: indicatorColors,
          ),
        );
      },
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.sweepAngleDegrees,
    required this.backgroundColors,
    required this.indicatorColors,
  });

  /// 0..1, drives the rotation of the moving arc.
  final double progress;
  final double strokeWidth;
  final double sweepAngleDegrees;
  final List<Color> backgroundColors;
  final List<Color> indicatorColors;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // 1. Background track — full circle with a linear gradient.
    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: backgroundColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    canvas.drawCircle(center, radius, backgroundPaint);

    // 2. Moving arc — rotates continuously, fading out along its trail.
    final sweepRadians = sweepAngleDegrees * math.pi / 180;
    final startAngle = progress * 2 * math.pi;

    final indicatorPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          indicatorColors.last.withOpacity(0),
          indicatorColors.first,
          indicatorColors.last,
        ],
        stops: const [0.0, 0.3, 1.0],
        startAngle: 0,
        endAngle: sweepRadians,
        transform: GradientRotation(startAngle),
      ).createShader(rect);

    canvas.drawArc(rect, startAngle, sweepRadians, false, indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.sweepAngleDegrees != sweepAngleDegrees ||
        oldDelegate.backgroundColors != backgroundColors ||
        oldDelegate.indicatorColors != indicatorColors;
  }
}