
import 'package:flutter/material.dart';
import 'package:one_ai/utility/constants/constant.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;

  final bool isPrimary;
  final bool isLoading;
  final bool expanded;

  final IconData? icon;
  final Widget? leading;

  /// Optional custom widget shown instead of the default bouncing dots.
  final Widget? loadingWidget;

  final double height;
  final double? width;
  final double borderRadius;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  /// Color of the bouncing dots. Defaults to a color that stays visible
  /// on the button background (see build()).
  final Color? loadingDotColor;

  const AppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isPrimary = true,
    this.isLoading = false,
    this.expanded = false,
    this.icon,
    this.leading,
    this.loadingWidget,
    this.height = 40,
    this.width,
    this.borderRadius = AppConstant.xl,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.loadingDotColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultForeground =
        isPrimary ? AppColors.appWhite : theme.colorScheme.primary;

    final gradient = LinearGradient(
      colors: isPrimary
          ? [AppColors.primary, AppColors.secondary]
          : theme.brightness == Brightness.dark
              ? [
                  AppColors.gradientSubtleDarkStart,
                  AppColors.gradientSubtleDarkEnd,
                ]
              : [
                  AppColors.gradientSubtleLightStart,
                  AppColors.gradientSubtleLightEnd,
                ],
    );

    final effectiveForeground = foregroundColor ?? defaultForeground;

    // On a primary (gradient) button, primary-colored dots would blend into
    // the background, so we use the foreground color there. On secondary
    // buttons the subtle background lets the primary color stand out.
    final effectiveDotColor = loadingDotColor ??
        (isPrimary ? effectiveForeground : AppColors.primary);

    final isDisabled = onTap == null || isLoading;

    Widget? buttonLeading;
    if (!isLoading) {
      if (leading != null) {
        buttonLeading = leading!;
      } else if (icon != null) {
        buttonLeading = Icon(
          icon,
          size: 20,
          color: effectiveForeground,
        );
      }
    }

    return Opacity(
      // Keep full opacity while loading so the dots stay vivid;
      // dim only when truly disabled.
      opacity: (onTap == null && !isLoading) ? 0.65 : 1,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: height,
          width: expanded ? double.infinity : width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: backgroundColor == null ? gradient : null,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null,
          ),
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: isLoading
                ? KeyedSubtree(
                    key: const ValueKey('loading'),
                    child: loadingWidget ??
                        _BouncingDots(color: effectiveDotColor),
                  )
                : Row(
                    key: const ValueKey('content'),
                    mainAxisSize:
                        expanded ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (buttonLeading != null) ...[
                        buttonLeading,
                        AppSpacing.w8,
                      ],
                      Flexible(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.45,
                            color: effectiveForeground,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Three dots that bounce one after another.
class _BouncingDots extends StatefulWidget {
  final Color color;
  final double dotSize;
  final double bounceHeight;

  const _BouncingDots({
    required this.color,
    this.dotSize = 10,
    this.bounceHeight = 6,
  });

  @override
  State<_BouncingDots> createState() => _BouncingDotsState();
}

class _BouncingDotsState extends State<_BouncingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Each dot gets its own time window inside the shared 0..1 loop,
  /// which creates the staggered "wave" effect.
  Animation<double> _dotAnimation(int index) {
    final start = index * 0.15;
    final end = start + 0.5;
    return TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.dotSize + widget.bounceHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(3, (index) {
          final animation = _dotAnimation(index);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.dotSize * 0.35),
            child: AnimatedBuilder(
              animation: animation,
              builder: (_, child) => Transform.translate(
                offset: Offset(0, animation.value * widget.bounceHeight),
                child: child,
              ),
              child: Container(
                width: widget.dotSize,
                height: widget.dotSize,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

