import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/action_tile.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/constants/app_border.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_shadow.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class ProfileCard extends StatelessWidget {
  final String userName;
  final String email;
  final String planName;
  final int usedQueries;
  final int totalQueries;
  final bool isOnline;
  final VoidCallback? onTap;
  const ProfileCard({
    super.key,
    required this.userName,
    required this.email,
    required this.planName,
    required this.usedQueries,
    required this.totalQueries,
    this.isOnline = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalQueries == 0 ? 0.0 : usedQueries / totalQueries;
    return InkWell(
      borderRadius: AppRadius.radiusXxl,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppRadius.radiusXxl,
          border: AppBorder.defaultBorder(context),
          boxShadow: [AppShadow.homeTileShadow],
        ),
        child: Column(
          children: [
            Row(
              children: [
                /// Avatar
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    LogoTile(
                      icon: Icons.person,
                      height: 85,
                      width: 85,
                      iconSize: 60,
                    ),

                    /// Online indicator
                    if (isOnline)
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.surface,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                AppSpacing.w16,

                /// User Info
                SizedBox(
                  height: 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading(context),
                      ),

                      Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.subHeading(
                          context,
                        ).copyWith(fontWeight: FontWeight.w400),
                      ),
                      Spacer(),

                      ActionTile(
                        verticalPadding: 4,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(icon: Icons.auto_awesome, size: 16),
                            AppSpacing.w4,
                            Text(
                              planName,
                              style: AppTextStyles.subHeading(
                                context,
                              ).copyWith(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.h12,

            /// Usage Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monthly usage",
                  style: AppTextStyles.subHeading(
                    context,
                  ).copyWith(fontWeight: FontWeight.w400),
                ),
                Text(
                  "$usedQueries / $totalQueries queries",
                  style: AppTextStyles.heading(context).copyWith(fontSize: 16),
                ),
              ],
            ),
            AppSpacing.h4,

            /// Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: AppColors.primary.withValues(alpha: .14),
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
