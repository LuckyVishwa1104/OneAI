import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_colors.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;

  const AppIcon({
    super.key,
    this.size = 24.0,
    this.color = AppColors.primary,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size, color: color);
  }
}
