import 'package:flutter/material.dart';
import 'package:one_ai/components/logo_tile.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
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
      padding: AppSpacing.defaultPadding,

      decoration: BoxDecoration(
        // color: const Color(0xFFFFFFFF),
        color: AppColors.surface,

        borderRadius: AppRadius.radiusXl,

        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          LogoTile(
            icon: logoIcon,
            height: logoHeight,
            width: logoWidth,
            iconSize: logoIconSize,
          ),

          AppSpacing.w12,

          Column(
            children: [
              Text(
                title,
                style: TextStyle(color: AppColors.textPrimary, fontSize: 25),
              ),
              AppSpacing.h4,
              Text(
                subTitle,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 20),
              ),
            ],
          ),

          /// furthre code fo holme tile component
        ],
      ),
    );
  }
}
