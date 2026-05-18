import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_shadow.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';

class HomeTile extends StatelessWidget {
  final IconData logoIcon;
  final double logoHeight;
  final double logoWidth;
  final double logoIconSize;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;
  const HomeTile({
    super.key,
    required this.logoIcon,
    this.logoHeight = 42,
    this.logoWidth = 42,
    this.logoIconSize = 25,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.xxlPadding,

      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusXl,
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [AppShadow.homeTileShadow],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              borderRadius: AppRadius.radiusMd,

              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE0E7FF), Color(0xFFF3E8FF)],
              ),
            ),

            child: Icon(logoIcon, size: 28, color: AppColors.primary),
          ),

          AppSpacing.w20,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                AppSpacing.h8,

                Text(
                  subTitle,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          /// furthre code fo holme tile component
        ],
      ),
    );
  }
}
