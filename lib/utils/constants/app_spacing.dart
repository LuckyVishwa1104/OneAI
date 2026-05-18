import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // default spacing
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xs = 4.0;
  static const double xxs = 2.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 40.0;
  static const double massive = 48.0;

  // height spacer
  static const Widget h2 = SizedBox(height: xxs);
  static const Widget h4 = SizedBox(height: xs);
  static const Widget h8 = SizedBox(height: sm);
  static const Widget h12 = SizedBox(height: md);
  static const Widget h16 = SizedBox(height: lg);
  static const Widget h20 = SizedBox(height: xl);
  static const Widget h24 = SizedBox(height: xxl);
  static const Widget h32 = SizedBox(height: xxxl);
  static const Widget h40 = SizedBox(height: huge);
  static const Widget h48 = SizedBox(height: massive);

  // width spacer
  static const Widget w2 = SizedBox(width: xxs);
  static const Widget w4 = SizedBox(width: xs);
  static const Widget w8 = SizedBox(width: sm);
  static const Widget w12 = SizedBox(width: md);
  static const Widget w16 = SizedBox(width: lg);
  static const Widget w20 = SizedBox(width: xl);
  static const Widget w24 = SizedBox(width: xxl);
  static const Widget w32 = SizedBox(width: xxxl);
  static const Widget w40 = SizedBox(width: huge);
  static const Widget w48 = SizedBox(width: massive);

  // app padding
  static const EdgeInsets defaultPadding = EdgeInsets.all(md);
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(horizontal: lg, vertical: md);
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(vertical: xxl);
  static const EdgeInsets containerPaddingSymHoriXs = EdgeInsets.symmetric(horizontal: xs);

}
