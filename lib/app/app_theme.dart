

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_ai/utils/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColorLight,
      foregroundColor: AppColors.textPrimaryLight,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.backgroundColorLight,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.backgroundColorLight,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    cardColor: AppColors.surfaceLight,
    dividerColor: AppColors.borderColorLight,
    textTheme: const TextTheme(
      bodyLarge:  TextStyle(color: AppColors.textPrimaryLight),
      bodyMedium: TextStyle(color: AppColors.textPrimaryLight),
      bodySmall:  TextStyle(color: AppColors.textSecondaryLight),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColorDark,
      foregroundColor: AppColors.textPrimaryDark,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.backgroundColorDark,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.backgroundColorDark,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    cardColor: AppColors.surfaceDark,
    dividerColor: AppColors.borderColorDark,
    textTheme: const TextTheme(
      bodyLarge:  TextStyle(color: AppColors.textPrimaryDark),
      bodyMedium: TextStyle(color: AppColors.textPrimaryDark),
      bodySmall:  TextStyle(color: AppColors.textSecondaryDark),
    ),
  );

}