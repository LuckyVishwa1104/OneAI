import 'package:flutter/material.dart';
import 'package:one_ai/screen/subscription/subscription_view_model.dart';
import 'package:one_ai/utility/components/animated_ai_icon.dart';
import 'package:one_ai/utility/components/app_bar/app_bar_component.dart';
import 'package:one_ai/utility/components/app_icon.dart';
import 'package:one_ai/utility/components/subscription_plan/billing_toggle.dart';
import 'package:one_ai/utility/components/subscription_plan/subscription_plan_card.dart';
import 'package:one_ai/utility/constants/app_border.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_shadow.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';
import 'package:stacked/stacked.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SubscriptionViewModel(),
      builder: (context, model, child) {
        final colorScheme = Theme.of(context).colorScheme;
        return Scaffold(
          appBar: AppBarComponent(
            isAction: false,
            title: "Manage Subscription",
          ),
          body: SingleChildScrollView(
            padding: AppSpacing.basePadding,
            child: Column(
              // padding: AppSpacing.basePadding,
              children: [
                AnimatedAiIcon(iconSize: 45),
                AppSpacing.h8,
                Text(
                  "Unlock OneAI's full power",
                  style: AppTextStyles.heading(context).copyWith(fontSize: 26),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Choose the plan that fits your needs",
                  style: AppTextStyles.subHeading(context).copyWith(fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.h20,
            
                BillingToggle(
                  isAnnual: model.isAnnual,
                  onChanged: model.toggleBilling,
                ),
                AppSpacing.h20,
            
                ...model.plans.map(
                  (plan) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: SubscriptionPlanCard(
                      plan: plan,
                      onTap: () => model.selectPlan(plan.id),
                    ),
                  ),
                ),
            
                SizedBox(
                  height: 115,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.quickHighlight.length,
                    separatorBuilder: (_, __) => AppSpacing.w12,
                    itemBuilder: (context, index) {
                      final item = model.quickHighlight[index];
            
                      return SizedBox(
                        width: 170,
                        child: Container(
                          padding: AppSpacing.basePadding,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: AppRadius.radiusXxl,
                            border: AppBorder.defaultBorder(context),
                            boxShadow: [AppShadow.homeTileShadow],
                          ),
                          child: Column(
                            children: [
                              AppIcon(icon: item.icon, size: 26),
                              AppSpacing.h8,
                              Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.heading(context).copyWith(fontSize: 16,),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (item.subtitle != null &&
                                  item.subtitle!.isNotEmpty) ...[
                                Text(
                                  item.subtitle!,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.subHeading(context).copyWith(fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AppSpacing.h48,
                
              ],
            ),
          ),
        );
      },
    );
  }
}
