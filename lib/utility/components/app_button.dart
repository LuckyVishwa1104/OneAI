import 'package:flutter/material.dart';
import 'package:one_ai/utility/constants/app_colors.dart';
import 'package:one_ai/utility/constants/app_constant.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isPrimary;
  final IconData? icon;
  const AppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isPrimary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColor = LinearGradient(
      colors:
          isPrimary
              ? [AppColors.primary, AppColors.secondary]
              : Theme.of(context).brightness == Brightness.dark
              ? [
                AppColors.gradientSubtleDarkStart,
                AppColors.gradientSubtleDarkEnd,
              ]
              : [
                AppColors.gradientSubtleLightStart,
                AppColors.gradientSubtleLightEnd,
              ],
    );
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstant.xl),
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: icon != null ? 16 : 0),
        decoration: BoxDecoration(
          gradient: gradientColor,
          borderRadius: BorderRadius.circular(AppConstant.xl),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color:
                    isPrimary
                        ? AppColors.appWhite
                        : Theme.of(context).colorScheme.primary,
              ),
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
                  color:
                      isPrimary
                          ? AppColors.appWhite
                          : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
