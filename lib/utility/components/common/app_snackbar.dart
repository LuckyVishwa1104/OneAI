import 'package:flutter/material.dart';
import 'package:one_ai/app/app_keys.dart';
import 'package:one_ai/utility/constants/constant.dart';

class AppSnackbar {
  void show({
    required String message,
    String? title,
    Color? backgroundColor,
    BorderSide? border,
    double? borderRadius,
    TextStyle? textStyle,
    TextStyle? titleStyle,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = AppKeys.scaffoldMessengerKey.currentState;

    if (messenger == null) return;

    final context = messenger.context;

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(title, style: titleStyle ?? AppTextStyles.heading(context)),
              AppSpacing.h4,
            ],
            Text(
              message,
              style: textStyle ?? AppTextStyles.subHeading(context),
            ),
          ],
        ),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: duration,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppConstant.xxl),
          side:
              border ??
              BorderSide(color: Theme.of(context).dividerColor, width: 1.2),
        ),
      ),
    );
  }
}
