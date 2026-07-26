import 'package:flutter/material.dart';
import 'package:one_ai/utility/components/action_tile.dart';
import 'package:one_ai/utility/constants/app_border.dart';
import 'package:one_ai/utility/constants/app_colors.dart';
import 'package:one_ai/utility/constants/app_shadow.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';

class BillingToggle extends StatelessWidget {
  final bool isAnnual;
  final ValueChanged<bool> onChanged;

  const BillingToggle({
    super.key,
    required this.isAnnual,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: AppBorder.defaultBorder(context),
        boxShadow: [AppShadow.homeTileShadow],
      ),
      child: Row(
        children: [
          _item(
            context,
            title: "Monthly",
            selected: !isAnnual,
            onTap: () => onChanged(false),
          ),
          _item(
            context,
            title: "Annual",
            selected: isAnnual,
            onTap: () => onChanged(true),
            badge: "-20%",
          ),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required String title,
    required bool selected,
    required VoidCallback onTap,
    String? badge,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient:
                selected
                    ? const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    )
                    : null,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyles.subHeading(context).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color:
                        selected
                            ? AppColors.appWhite
                            : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (badge != null) ...[
                  AppSpacing.w8,
                  ActionTile(verticalPadding: 3, child: Text(badge)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
