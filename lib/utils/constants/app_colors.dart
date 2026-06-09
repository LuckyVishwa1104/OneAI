import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary / Secondary (same in both modes)
  static const Color primary   = Color(0xFF7B3FF2);
  static const Color secondary = Color(0xFF4F6BFF);

  // Lightning bolt (same in both modes)
  static const Color innerBolt = Color(0xFFFF8F00);
  static const Color outerBolt = Color(0xFFFFEB3B);

  // ── Light ────────────────────────────────────────────
  static const Color backgroundColorLight = Color(0xFFFAFAFA);
  static const Color surfaceLight         = Color(0xFFFFFFFF);
  static const Color textPrimaryLight     = Color(0xFF212121);
  static const Color textSecondaryLight   = Color(0xFF757575);
  static const Color borderColorLight     = Color(0xFFDCE3ED);

  // ── Dark ─────────────────────────────────────────────
  static const Color backgroundColorDark  = Color(0xFF121212);
  static const Color surfaceDark          = Color(0xFF1E1E1E);
  static const Color textPrimaryDark      = Color(0xFFF5F5F5);
  static const Color textSecondaryDark    = Color(0xFFAAAAAA);
  static const Color borderColorDark      = Color(0xFF2C2C2C);

  // ── Legacy aliases (so existing code doesn't break) ──
  static const Color backgroundColor  = backgroundColorLight;
  static const Color surface          = surfaceLight;
  static const Color textPrimary      = textPrimaryLight;
  static const Color textSecondary    = textSecondaryLight;
  static const Color borderColor      = borderColorLight;
  static const Color appBlack         = Colors.black;
  static const Color appWhite         = Colors.white;
  
}
