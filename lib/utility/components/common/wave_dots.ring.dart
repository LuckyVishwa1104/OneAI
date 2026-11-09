import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Three concentric layers of dots around [child] that animate like water
/// ripples after a stone drops in the middle.
///
/// Layout:
///  - Layer 0 = inner (largest dots), layer 2 = outer (smallest dots).
///  - Dot sizes are FIXED per layer (they never grow or shrink).
///  - Every layer uses the SAME angles, so inner dots sit radially in front
///    of the dots behind them.
///
/// Animation (one looping cycle):
///  The ripple starts at the center, moves outward layer by layer, weakens
///  with distance, settles, then repeats. Only the dots' radial position and
///  opacity change.
class WaveDotsRing extends StatefulWidget {
  const WaveDotsRing({
    super.key,
    required this.child,
    required this.color,

    // ======================================================================
    // AREA CONTROLS - these decide how much space the ripple covers
    // ======================================================================

    /// (1) TOTAL AREA of the ripple, in logical pixels (width = height).
    /// Bigger value = the whole ripple spreads over a larger circle.
    /// The outermost layer always sits near the edge of this area.
    this.size = 280,

    /// (2) INNER START of the ripple as a fraction (0..1) of the available
    /// radius. This is the gap between the logo and the first layer of dots.
    /// Smaller value = dots start closer to the logo (layers get more
    /// spread out). Larger value = dots start further away (layers get
    /// tighter). Keep it above the logo's own radius.
    this.innerRadiusFactor = 0.56,

    // ----------------------------------------------------------------------
    this.dotsPerLayer = 8,
    this.duration = const Duration(milliseconds: 2800),
  }) : assert(innerRadiusFactor > 0 && innerRadiusFactor < 1);

  /// Widget placed in the center (e.g. LogoTile).
  final Widget child;

  /// Base dot color (e.g. AppColors.primary).
  final Color color;

  /// See "AREA CONTROLS" in the constructor.
  final double size;
  final double innerRadiusFactor;

  /// Number of dots in each layer.
  final int dotsPerLayer;

  /// Time between one drop and the next.
  final Duration duration;

  @override
  State<WaveDotsRing> createState() => _WaveDotsRingState();
}

class _WaveDotsRingState extends State<WaveDotsRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Respect the OS "reduce motion" accessibility setting.
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    if (reduceMotion) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              size: Size.square(widget.size),
              painter: _RipplePainter(
                animation: _controller,
                color: widget.color,
                dotsPerLayer: widget.dotsPerLayer,
                innerRadiusFactor: widget.innerRadiusFactor,
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class _RipplePainter extends CustomPainter {
  _RipplePainter({
    required this.animation,
    required this.color,
    required this.dotsPerLayer,
    required this.innerRadiusFactor,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color color;
  final int dotsPerLayer;
  final double innerRadiusFactor;

  // ---- Fixed dot sizes: index 0 = INNER (largest) -> 2 = OUTER (smallest) --
  static const _dotRadii = [6.3, 4.9, 3.6];

  // Opacity at rest per layer.
  static const _restAlpha = [0.55, 0.45, 0.35];

  // ---- Ripple tuning ------------------------------------------------------
  /// Fraction of the cycle the ripple front takes to reach the outer layer.
  static const _travel = 0.40;

  /// Oscillations per cycle after the front arrives (more = more rings).
  static const _frequency = 1.6;

  /// How quickly each layer's oscillation dies out.
  static const _decay = 3.2;

  /// How much weaker the ripple gets at the outer layer (0..1).
  static const _distanceLoss = 0.3;

  /// Max radial movement (px) and opacity change at full strength.
  static const _radialAmplitude = 9.0;
  static const _alphaAmplitude = 0.45;

  final Paint _paint = Paint()..isAntiAlias = true;

  static double _smoothstep(double edge0, double edge1, double x) {
    final t = ((x - edge0) / (edge1 - edge0)).clamp(0.0, 1.0);
    return t * t * (3 - 2 * t);
  }

  /// Water-like displacement for a layer, in the range roughly -1..1.
  double _energy(double t, double distance) {
    final u = t - distance * _travel; // time since the front reached this layer
    if (u <= 0) return 0;

    final onset = _smoothstep(0, 0.07, u); // front rises smoothly
    final envelope = math.exp(-_decay * u); // oscillation fades out
    final oscillation = math.sin(2 * math.pi * _frequency * u);
    final strength = 1 - _distanceLoss * distance; // weaker further out
    // Fade to calm at the end so the loop restarts without a jump.
    final endFade = 1 - _smoothstep(0.85, 1.0, t);

    return onset * envelope * oscillation * strength * endFade;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    // Keep the outer dots fully inside the area, including their movement.
    final maxRadius =
        size.shortestSide / 2 - _dotRadii.first - _radialAmplitude;
    final step = 2 * math.pi / dotsPerLayer;
    final t = animation.value;
    final layers = _dotRadii.length;

    // Paint outer first, inner last, so inner dots sit in front.
    for (var layer = layers - 1; layer >= 0; layer--) {
      final distance = layer / (layers - 1); // 0 inner .. 1 outer

      // Layers are spread evenly from innerRadiusFactor out to the edge.
      final factor = innerRadiusFactor + (1 - innerRadiusFactor) * distance;

      final e = _energy(t, distance);
      final radius = maxRadius * factor + e * _radialAmplitude;
      final alpha =
          (_restAlpha[layer] + _alphaAmplitude * e).clamp(0.1, 1.0).toDouble();

      _paint.color = color.withValues(alpha: alpha);

      for (var i = 0; i < dotsPerLayer; i++) {
        final angle = i * step - math.pi / 2; // first dot at the top
        final position =
            center + Offset(math.cos(angle), math.sin(angle)) * radius;
        canvas.drawCircle(position, _dotRadii[layer], _paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RipplePainter old) =>
      old.color != color ||
      old.dotsPerLayer != dotsPerLayer ||
      old.innerRadiusFactor != innerRadiusFactor;
}