import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;

  const AppIcon({
    super.key,
    this.size = 24.0,
    this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size, color: color ?? Theme.of(context).colorScheme.primary, );
  }
}
