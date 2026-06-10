import 'package:flutter/material.dart';

class AppBorder {
  AppBorder._();

  static Border defaultBorder(BuildContext context) => Border.all(
    color: Theme.of(context).dividerColor,
    width: 1.2,
  );

  static BorderSide defaultBorderSide(BuildContext context) => BorderSide(
    color: Theme.of(context).dividerColor,
    width: 1.2,
  );
}
