import 'package:flutter/material.dart';
import 'package:one_ai/utility/constants/app_colors.dart';

class AppToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;

  const AppToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final gradientColors =
        isDarkMode
            ? [
              AppColors.gradientSubtleDarkStart,
              AppColors.gradientSubtleDarkEnd,
            ]
            : [
              AppColors.gradientSubtleLightStart,
              AppColors.gradientSubtleLightEnd,
            ];

    return Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: activeTrackColor ?? AppColors.primary,
      inactiveTrackColor: inactiveTrackColor ?? gradientColors[0],
      activeThumbColor: activeThumbColor ?? gradientColors[1],
      inactiveThumbColor: inactiveThumbColor ?? AppColors.primary,
    );
  }
}
