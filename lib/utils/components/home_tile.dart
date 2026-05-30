import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/constants/app_border.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_shadow.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

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
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.xlPadding,

        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.radiusXxl,
          border: AppBorder.defaultBorder,
          boxShadow: [AppShadow.homeTileShadow],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            LogoTile(icon: logoIcon, isLogo: false, height: 52, width: 52),

            AppSpacing.w20,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.heading,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  AppSpacing.h8,

                  Text(
                    subTitle,
                    style: AppTextStyles.subHeading,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            /// furthre code fo holme tile component
          ],
        ),
      ),
    );
  }
}
