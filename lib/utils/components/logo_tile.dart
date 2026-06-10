import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart' show AppRadius;

class LogoTile extends StatelessWidget {
  final bool isLogo;
  final bool isCircular;
  final double height;
  final double width;
  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final VoidCallback? onTap;
  const LogoTile({
    super.key,
    this.isLogo = true,
    this.isCircular = false,
    this.height = 42,
    this.width = 42,
    this.iconSize = 28,
    this.iconColor,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                isLogo
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,

          borderRadius:
              isCircular
                  ? null
                  : (isLogo ? AppRadius.radiusLg : AppRadius.radiusMd),
        ),

        child: AppIcon(
          icon: icon,
          color:
              isLogo
                  ? AppColors.appWhite
                  : iconColor ?? Theme.of(context).colorScheme.primary,
          size: iconSize,
        ),
      ),
    );
  }
}
