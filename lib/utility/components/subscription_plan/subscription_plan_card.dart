import 'package:flutter/material.dart';
import 'package:one_ai/model/subscription_model.dart';
import 'package:one_ai/utility/components/action_tile.dart';
import 'package:one_ai/utility/components/logo_tile.dart';
import 'package:one_ai/utility/constants/app_border.dart';
import 'package:one_ai/utility/constants/app_colors.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_shadow.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final VoidCallback onTap;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: AppRadius.radiusXxl,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppRadius.radiusXxl,
          border:
              plan.isSelected
                  ? Border.all(color: AppColors.primary, width: 1.4)
                  : AppBorder.defaultBorder(context),
          boxShadow: [AppShadow.homeTileShadow],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                LogoTile(
                  icon: plan.icon,
                  iconColor: AppColors.appWhite,
                  // gradient: LinearGradient(
                  //   colors: [
                  //     plan.iconColor,
                  //     AppColors.secondary,
                  //   ],
                  // ),
                ),

                AppSpacing.w12,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            plan.title,
                            style: AppTextStyles.heading(
                              context,
                            ).copyWith(fontSize: 22),
                          ),

                          if (plan.isCurrent) ...[
                            AppSpacing.w8,
                            ActionTile(
                              child: Text(
                                "Current",
                                style: AppTextStyles.subHeading(
                                  context,
                                ).copyWith(color: Colors.green),
                              ),
                            ),
                          ],
                        ],
                      ),

                      AppSpacing.h4,

                      Text(
                        plan.subtitle,
                        style: AppTextStyles.subHeading(context),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (plan.badge != null)
                      ActionTile(
                        // backgroundColor:
                        //     AppColors.primary.withOpacity(.15),
                        child: Text(
                          plan.badge!,
                          style: AppTextStyles.subHeading(
                            context,
                          ).copyWith(color: AppColors.primary),
                        ),
                      ),

                    AppSpacing.h8,

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: plan.price,
                            style: AppTextStyles.heading(
                              context,
                            ).copyWith(fontSize: 28),
                          ),

                          TextSpan(
                            text: plan.duration,
                            style: AppTextStyles.subHeading(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            AppSpacing.h16,

            Divider(color: Theme.of(context).dividerColor),

            AppSpacing.h16,

            ...plan.features
                .take(5)
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                            ),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),

                        AppSpacing.w12,

                        Expanded(
                          child: Text(
                            feature,
                            style: AppTextStyles.subHeading(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

            if (plan.features.length > 5)
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Text(
                  "+${plan.features.length - 5} more features",
                  style: AppTextStyles.subHeading(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
