import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_constant.dart' show AppConstant;

class AppSpacing {
  AppSpacing._();

  // height spacer
  static const Widget h2 = SizedBox(height: AppConstant.xxs);
  static const Widget h4 = SizedBox(height: AppConstant.xs);
  static const Widget h8 = SizedBox(height: AppConstant.sm);
  static const Widget h12 = SizedBox(height: AppConstant.md);
  static const Widget h16 = SizedBox(height: AppConstant.lg);
  static const Widget h20 = SizedBox(height: AppConstant.xl);
  static const Widget h24 = SizedBox(height: AppConstant.xxl);
  static const Widget h32 = SizedBox(height: AppConstant.xxxl);
  static const Widget h40 = SizedBox(height: AppConstant.huge);
  static const Widget h48 = SizedBox(height: AppConstant.massive);

  // width spacer
  static const Widget w2 = SizedBox(width: AppConstant.xxs);
  static const Widget w4 = SizedBox(width: AppConstant.xs);
  static const Widget w8 = SizedBox(width: AppConstant.sm);
  static const Widget w12 = SizedBox(width: AppConstant.md);
  static const Widget w16 = SizedBox(width: AppConstant.lg);
  static const Widget w20 = SizedBox(width: AppConstant.xl);
  static const Widget w24 = SizedBox(width: AppConstant.xxl);
  static const Widget w32 = SizedBox(width: AppConstant.xxxl);
  static const Widget w40 = SizedBox(width: AppConstant.huge);
  static const Widget w48 = SizedBox(width: AppConstant.massive);

  // app padding
  static const EdgeInsets basePadding = EdgeInsets.all(AppConstant.base);
  static const EdgeInsets defaultPadding = EdgeInsets.all(AppConstant.md);
  static const EdgeInsets defaultHorizontalPadding = EdgeInsets.symmetric(
    horizontal: AppConstant.md,
  );
  static const EdgeInsets largePadding = EdgeInsets.all(AppConstant.lg);
  static const EdgeInsets xlPadding = EdgeInsets.all(AppConstant.xl);
  static const EdgeInsets xxlPadding = EdgeInsets.all(AppConstant.xxl);
  static const EdgeInsets xxsPadding = EdgeInsets.all(AppConstant.xxs);
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: AppConstant.lg,
    vertical: AppConstant.md,
  );
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    vertical: AppConstant.xxl,
  );
  static const EdgeInsets containerPaddingSymHoriXs = EdgeInsets.symmetric(
    horizontal: AppConstant.xs,
  );
}
