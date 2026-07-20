import 'package:flutter/material.dart';
import 'package:one_ai/utility/constants/app_colors.dart';

class AppShadow {
  AppShadow._();

  static final BoxShadow homeTileShadow = BoxShadow(
    color: AppColors.appBlack.withValues(alpha: 0.04),
    blurRadius: 18,
    offset: const Offset(0, 6),
  );

  static final BoxShadow actionContainer = BoxShadow(
    color: AppColors.appBlack.withValues(alpha: 0.02),
    blurRadius: 8,
    offset: const Offset(0, 2),
  );

}
