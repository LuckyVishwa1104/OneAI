import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/constant.dart';

class GradientCircularProgressIndicator extends StatefulWidget {
  const GradientCircularProgressIndicator({
    super.key,
    this.size = 38,
    this.strokeWidth = 2.5,
    this.sweepAngle = 210,
    this.duration = const Duration(milliseconds: 1200),
  });

  final double size;
  final double strokeWidth;

  /// Length of the moving arc in degrees.
  final double sweepAngle;

  /// Speed of the animation.
  final Duration duration;

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

    final gradientColors =
        isDark
            ? [
              AppColors.gradientSubtleDarkStart,
              AppColors.gradientSubtleDarkEnd,
            ]
            : [
              AppColors.gradientSubtleLightStart,
              AppColors.gradientSubtleLightEnd,
            ];

    return Container(
      padding: EdgeInsets.all(8),
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _GradientCircularProgressPainter(
              progress: _controller.value,
              strokeWidth: widget.strokeWidth,
              sweepAngleDegrees: widget.sweepAngle,
            ),
          );
        },
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  const _GradientCircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.sweepAngleDegrees,
  });

  final double progress;
  final double strokeWidth;
  final double sweepAngleDegrees;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final radius = (size.shortestSide - strokeWidth) / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final sweepRadians = sweepAngleDegrees * math.pi / 180;

    final startAngle = progress * 2 * math.pi;

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = AppColors.primary;

    canvas.drawArc(rect, startAngle, sweepRadians, false, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.sweepAngleDegrees != sweepAngleDegrees;
  }
}
