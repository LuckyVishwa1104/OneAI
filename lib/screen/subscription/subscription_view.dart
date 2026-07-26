import 'package:flutter/material.dart';
import 'package:one_ai/screen/subscription/subscription_view_model.dart';
import 'package:one_ai/utility/components/app_bar/app_bar_component.dart';
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
        return Scaffold(
          appBar: AppBarComponent(
            isAction: false,
            title: "Manage Subscription",
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                BillingToggle(
                  isAnnual: model.isAnnual,
                  onChanged: model.toggleBilling,
                ),

                AppSpacing.h20,

                // const CurrentPlanBanner(),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: AppRadius.radiusXxl,
                    border: AppBorder.defaultBorder(context),
                    boxShadow: [AppShadow.homeTileShadow],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      ),

                      AppSpacing.w12,

                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "You're on the ",
                              style: AppTextStyles.subHeading(context),
                            ),

                            TextSpan(
                              text: "Free",
                              style: AppTextStyles.heading(context),
                            ),

                            TextSpan(
                              text: " plan",
                              style: AppTextStyles.subHeading(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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

                // AppSpacing.h20,
                // const ComparisonTable(),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).colorScheme.surface,
                //     borderRadius: AppRadius.radiusXxl,
                //     border: AppBorder.defaultBorder(context),
                //     boxShadow: [AppShadow.homeTileShadow],
                //   ),
                //   child: ExpansionTile(
                //     title: Text(
                //       "Compare all plans",
                //       style: AppTextStyles.heading(context),
                //     ),
                //     children: [
                //       // SubscriptionComparisonTable(),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
