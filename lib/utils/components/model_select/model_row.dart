import 'package:flutter/material.dart';
import 'package:one_ai/model/ai_model.dart';
import 'package:one_ai/utils/components/action_tile.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/constants/app_border.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_shadow.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class ModelRow extends StatelessWidget {
  final AiModel model;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isSelectedHeader;

  const ModelRow({
    super.key,
    required this.model,
    required this.isSelected,
    this.isSelectedHeader = false,
    this.onTap,
  });

  String badgeLabel(ModelBadge badge) {
    switch (badge) {
      case ModelBadge.isNew:
        return 'New';
      case ModelBadge.pro:
        return 'Pro';
      case ModelBadge.preview:
        return 'Preview';
      case ModelBadge.none:
        return '';
    }
  }

  String tierLabel(ModelTier tier) {
    switch (tier) {
      case ModelTier.fast:
        return 'Fast';
      case ModelTier.balanced:
        return 'Balanced';
      case ModelTier.powerful:
        return 'Powerful';
    }
  }

  IconData tierIcon(ModelTier tier) {
    switch (tier) {
      case ModelTier.fast:
        return Icons.bolt_rounded;

      case ModelTier.balanced:
        return Icons.balance_rounded;

      case ModelTier.powerful:
        return Icons.workspace_premium_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: model.isLocked ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppRadius.radiusXxl,
          border: isSelectedHeader ? AppBorder.defaultBorder(context) :
              isSelected
                  ? Border.all(color: colorScheme.primary, width: 1.2)
                  : AppBorder.defaultBorder(context),
          boxShadow: [AppShadow.homeTileShadow],
        ),
        child: Row(
          children: [
            isSelectedHeader ? LogoTile(icon: Icons.rocket_launch_outlined, isCircular: true, iconSize: 22,) :
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors:
                      isSelected
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
              ),
              child:
                  isSelected
                      ? Icon(Icons.check, size: 14, color: AppColors.appWhite)
                      : null,
            ),

            AppSpacing.w12,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          model.name,
                          style: AppTextStyles.heading(
                            context,
                          ).copyWith(fontSize: 18.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      
                      // Badge for model status 
                      // if (model.badge != ModelBadge.none) ...[
                      //   AppSpacing.w8,
                      //   ActionTile(
                      //     verticalPadding: 4,
                      //     child: Text(
                      //       badgeLabel(model.badge),
                      //       style: AppTextStyles.subHeading(
                      //         context,
                      //       ).copyWith(fontSize: 14),
                      //     ),
                      //   ),
                      // ],

                      AppSpacing.w4,

                      if (model.isLocked) ...[
                        AppSpacing.w4,
                        AppIcon(
                          icon: Icons.lock_outline,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ],
                    ],
                  ),
                  AppSpacing.h2,
                  Text(
                    model.description,
                    style: AppTextStyles.subHeading(
                      context,
                    ).copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),

            AppSpacing.w8,

            ActionTile(
              verticalPadding: 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(icon: tierIcon(model.tier), size: 16),
                  AppSpacing.w4,
                  Text(
                    tierLabel(model.tier),
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
    );
  }
}
