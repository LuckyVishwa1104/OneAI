import 'package:flutter/material.dart';
import 'package:one_ai/app/app_keys.dart';
import 'package:one_ai/model/enums/snackbar_type.dart';
import 'package:one_ai/utility/constants/constant.dart';

class AppSnackbar {
  // Base accent colors (used for border + tinted background)
  static const Color _successColor = Color(0xFF22C55E); // green-500
  static const Color _errorColor = Color(0xFFEF4444); // red-500

  void show({
    required String message,
    String? title,
    Color? backgroundColor,
    BorderSide? border,
    double? borderRadius,
    TextStyle? textStyle,
    TextStyle? titleStyle,
    Duration duration = const Duration(seconds: 3),
    SnackbarType type = SnackbarType.normal,
  }) {
    final messenger = AppKeys.scaffoldMessengerKey.currentState;
    if (messenger == null) return;

    final context = messenger.context;
    final theme = Theme.of(context);

    messenger.hideCurrentSnackBar();

    // Resolve colors per type
    Color resolvedBackground;
    Color resolvedBorderColor;
    Color? resolvedTextColor; // null => fall back to theme text styles
    IconData? leadingIcon; // null => no icon (normal type)

    switch (type) {
      case SnackbarType.success:
        resolvedBackground = _successColor.withValues(alpha: 0.80);
        resolvedBorderColor = _successColor;
        resolvedTextColor = Colors.white;
        leadingIcon = Icons.check_rounded;
        break;
      case SnackbarType.error:
        resolvedBackground = _errorColor.withValues(alpha: 0.80);
        resolvedBorderColor = _errorColor;
        resolvedTextColor = Colors.white;
        leadingIcon = Icons.error_outline_rounded;
        break;
      case SnackbarType.normal:
        resolvedBackground = theme.colorScheme.surface;
        resolvedBorderColor = theme.dividerColor;
        resolvedTextColor = null;
        leadingIcon = null;
        break;
    }

    // Allow caller overrides
    resolvedBackground = backgroundColor ?? resolvedBackground;

    // Text styles (white for success/error, theme default for normal)
    final effectiveTitleStyle =
        titleStyle ??
        AppTextStyles.heading(
          context,
        ).copyWith(fontSize: 16, color: resolvedTextColor);

    final effectiveMessageStyle =
        textStyle ??
        AppTextStyles.subHeading(context).copyWith(color: resolvedTextColor);

    // Position at the top: push the snackbar up with a large bottom margin
    final mediaQuery = MediaQuery.of(context);
    final topInset = mediaQuery.padding.top; // status bar / notch
    final estimatedHeight = title != null ? 96.0 : 68.0;
    final bottomMargin =
        mediaQuery.size.height - topInset - estimatedHeight - 12;

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                child: Icon(leadingIcon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Text(
                      title,
                      style: effectiveTitleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpacing.h4,
                  ],
                  Text(
                    message,
                    style: effectiveMessageStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: resolvedBackground,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: duration,
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: bottomMargin),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppConstant.lg),
          side: border ?? BorderSide(color: resolvedBorderColor, width: 1.2),
        ),
      ),
    );
  }
}
