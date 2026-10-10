
import 'package:flutter/material.dart';
import 'package:one_ai/utility/constants/constant.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;

  final bool isPrimary;
  final bool isLoading;
  final bool expanded;

  final IconData? icon;
  final Widget? leading;
  final Widget? loadingWidget;

  final double height;
  final double? width;
  final double borderRadius;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isPrimary = true,
    this.isLoading = false,
    this.expanded = false,
    this.icon,
    this.leading,
    this.loadingWidget,
    this.height = 40,
    this.width,
    this.borderRadius = AppConstant.xl,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultForeground =
        isPrimary
            ? AppColors.appWhite
            : theme.colorScheme.primary;

    final gradient = LinearGradient(
      colors: isPrimary
          ? [AppColors.primary, AppColors.secondary]
          : theme.brightness == Brightness.dark
              ? [
                  AppColors.gradientSubtleDarkStart,
                  AppColors.gradientSubtleDarkEnd,
                ]
              : [
                  AppColors.gradientSubtleLightStart,
                  AppColors.gradientSubtleLightEnd,
                ],
    );

    final effectiveForeground =
        foregroundColor ?? defaultForeground;

    final isDisabled = onTap == null || isLoading;

    Widget? buttonLeading;

    if (isLoading) {
      buttonLeading = SizedBox(
        width: 20,
        height: 20,
        child: loadingWidget ??
            CircularProgressIndicator(
              strokeWidth: 2,
              color: effectiveForeground,
            ),
      );
    } else if (leading != null) {
      buttonLeading = leading!;
    } else if (icon != null) {
      buttonLeading = Icon(
        icon,
        size: 20,
        color: effectiveForeground,
      );
    }

    return Opacity(
      opacity: isDisabled ? 0.65 : 1,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: height,
          width: expanded ? double.infinity : width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient:
                backgroundColor == null ? gradient : null,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null
                ? Border.all(color: borderColor!)
                : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize:
                expanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonLeading != null) ...[
                buttonLeading,
                AppSpacing.w8,
              ],
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                    color: effectiveForeground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
