import 'package:flutter/material.dart';
import 'package:one_ai/utility/constants/app_border.dart';
import 'package:one_ai/utility/constants/app_colors.dart';

class AppToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  final Color? activeTrackColor;
  final Color? inactiveThumbColor;

  const AppToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.inactiveThumbColor,
  });

  static const double _width = 52;
  static const double _height = 32;
  static const double _thumbSize = 24;
  static const double _padding = 4;
  static const Duration _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:
          isDarkMode
              ? [
                AppColors.gradientSubtleDarkStart,
                AppColors.gradientSubtleDarkEnd,
              ]
              : [
                AppColors.gradientSubtleLightStart,
                AppColors.gradientSubtleLightEnd,
              ],
    );

    return Semantics(
      toggled: value,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        onHorizontalDragEnd: (details) {
          final v = details.primaryVelocity ?? 0;
          if (v > 0 && !value) onChanged(true);
          if (v < 0 && value) onChanged(false);
        },
        child: AnimatedContainer(
          duration: _duration,
          curve: Curves.easeInOut,
          width: _width,
          height: _height,
          padding: const EdgeInsets.all(_padding),
          decoration: BoxDecoration(
            border: value ? null : AppBorder.defaultBorder(context),
            borderRadius: BorderRadius.circular(_height / 2),
            // Inactive track: gradient. Active track: solid color.
            gradient: value ? null : gradient,
            color: value ? (activeTrackColor ?? AppColors.primary) : null,
          ),
          child: AnimatedAlign(
            duration: _duration,
            curve: Curves.easeInOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: _thumbSize,
              height: _thumbSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Active thumb: gradient. Inactive thumb: solid color.
                gradient: value ? gradient : null,
                color: value ? null : (inactiveThumbColor ?? AppColors.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
