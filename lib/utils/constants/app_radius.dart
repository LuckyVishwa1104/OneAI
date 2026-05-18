import 'package:flutter/painting.dart';

class AppRadius {
  AppRadius._();

  // Radius values
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 18;
  static const double xl = 24;
  static const double xxl = 32;

  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusXxl = BorderRadius.all(Radius.circular(xxl));
  
}
