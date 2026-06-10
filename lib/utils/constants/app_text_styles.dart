import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading(BuildContext context) => TextStyle(
    color: Theme.of(context).colorScheme.onSurface,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.1,
  );

  static TextStyle subHeading(BuildContext context) => TextStyle(
    color: Theme.of(context).colorScheme.onSurfaceVariant,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.45,
  );
  
}
