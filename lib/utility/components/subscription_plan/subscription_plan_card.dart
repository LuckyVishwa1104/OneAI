import 'package:flutter/material.dart';
import 'package:one_ai/model/subscription_model.dart';
import 'package:one_ai/utility/components/action_tile.dart';
import 'package:one_ai/utility/components/app_button.dart';
import 'package:one_ai/utility/components/logo_tile.dart';
import 'package:one_ai/utility/constants/app_border.dart';
import 'package:one_ai/utility/constants/app_colors.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_shadow.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';

class SubscriptionPlanCard extends StatefulWidget {
  final SubscriptionPlan plan;
  final VoidCallback onTap;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.onTap,
  });

  @override
  State<SubscriptionPlanCard> createState() => _SubscriptionPlanCardState();
}

class _SubscriptionPlanCardState extends State<SubscriptionPlanCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final visibleFeatures =
        _expanded
            ? widget.plan.features
            : widget.plan.features.take(3).toList();
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppRadius.radiusXxl,
        border:
            widget.plan.isSelected
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
                height: 49,
                width: 49,
                icon: widget.plan.icon,
                isLogo: false ,
              ),

              AppSpacing.w12,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.plan.title,
                      style: AppTextStyles.heading(
                        context,
                      ).copyWith(fontSize: 20),
                    ),

                    Text(
                      widget.plan.subtitle,
                      style: AppTextStyles.subHeading(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              ActionTile(
                verticalPadding: 4,
                child: Text(
                  widget.plan.badge!,
                  style: AppTextStyles.subHeading(
                    context,
                  ).copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          AppSpacing.h4,

          Divider(color: Theme.of(context).dividerColor,),
          AppSpacing.h4,

          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: Column(
              children: List.generate(visibleFeatures.length, (index) {
                final feature = visibleFeatures[index];
                final isLast = index == visibleFeatures.length - 1;

                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                  child: Row(
                    children: [
                      LogoTile(
                        icon: Icons.check_rounded,
                        isLogo: false,
                        isCircular: true,
                        iconSize: 16,
                        height: 28,
                        width: 28,
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
                );
              }),
            ),
          ),
          if (!_expanded && widget.plan.features.length > 3)
            Column(
              children: [
                AppSpacing.h8,
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() {
                      _expanded = true;
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.keyboard_arrow_down_rounded),
                      AppSpacing.w4,
                      Text(
                        "${widget.plan.features.length - 3} more features",
                        style: AppTextStyles.heading(
                          context,
                        ).copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          
          if (!widget.plan.isCurrent && !widget.plan.isSelected)
            Column(
              children: [
                AppSpacing.h12,
                AppButton(
                  onTap: () {},
                  title: "${widget.plan.price}${widget.plan.duration} - Try Now",
                ),
              ],
            ),
        ],
      ),
    );
  }
}
