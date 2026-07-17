import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_constant.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isPrimary;
  const AppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isPrimary = true,
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
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          gradient: gradientColor,
          borderRadius: BorderRadius.circular(AppConstant.xl),
        ),
        alignment: Alignment.center,
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
    );
  }
}
