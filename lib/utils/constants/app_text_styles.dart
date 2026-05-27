import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.1,
  );

  static TextStyle subHeading = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.45,
  );
  
}
