import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_colors.dart';

class AppBorder {
  AppBorder._();

  static final Border defaultBorder = Border.all(
    color: AppColors.borderColor,
    width: 1.2,
  );

  static final BorderSide defaultBorderSide = BorderSide(
    color: AppColors.borderColor,
    width: 1.2,
  );
}
