import 'dart:async';

import 'package:flutter/material.dart';
import 'package:one_ai/model/enums/snackbar_type.dart';
import 'package:one_ai/utility/constants/constant.dart';
import 'package:stacked_services/stacked_services.dart';

class AppSnackbar {
  static const Color _successColor = Color(0xFF22C55E);
  static const Color _errorColor = Color(0xFFEF4444);

  static OverlayEntry? _entry;
  static Timer? _timer;

  static void _dismiss() {
    _timer?.cancel();
    _timer = null;
    _entry?.remove();
    _entry = null;
  }

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
    final overlay = StackedService.navigatorKey?.currentState?.overlay;
    if (overlay == null) return;

    final context = overlay.context;
    final theme = Theme.of(context);

    _dismiss(); // replaces hideCurrentSnackBar()

    Color resolvedBackground;
    Color resolvedBorderColor;
    Color? resolvedTextColor;
    IconData? leadingIcon;

    switch (type) {
      case SnackbarType.success:
        resolvedBackground = _successColor.withValues(alpha: 0.85);
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

    resolvedBackground = backgroundColor ?? resolvedBackground;

    final effectiveTitleStyle = titleStyle ??
        AppTextStyles.heading(context)
            .copyWith(fontSize: 16, color: resolvedTextColor);
    final effectiveMessageStyle = textStyle ??
        AppTextStyles.subHeading(context).copyWith(color: resolvedTextColor);

    final content = Row(
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
    );

    _entry = OverlayEntry(
      builder: (_) => SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              builder: (_, value, child) => Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, -24 * (1 - value)),
                  child: child,
                ),
              ),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.up,
                onDismissed: (_) => _dismiss(),
                child: Material(
                  color: resolvedBackground,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(borderRadius ?? AppConstant.lg),
                    side: border ??
                        BorderSide(color: resolvedBorderColor, width: 1.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: content,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_entry!);
    _timer = Timer(duration, _dismiss);
  }
}