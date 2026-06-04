import 'package:flutter/painting.dart';
import 'package:one_ai/utils/constants/app_constant.dart' show AppConstant;

class AppRadius {
  AppRadius._();

  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(AppConstant.xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(AppConstant.sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(AppConstant.md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(AppConstant.lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(AppConstant.xl));
  static const BorderRadius radiusXxl = BorderRadius.all(Radius.circular(AppConstant.xxl));

  static const BorderRadius radiusCirular = BorderRadius.all(Radius.circular(50));

  static const BorderRadius radiusXxlTop = BorderRadius.only(topLeft: Radius.circular(AppConstant.xxl), topRight: Radius.circular(AppConstant.xxl));
  
}
