import 'package:flutter/material.dart';

class AppShadow {
  AppShadow._();

  static final BoxShadow homeTileShadow = BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 18,
    offset: const Offset(0, 6),
  );
}
