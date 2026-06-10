import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/app_bar/app_bar_action.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final bool isTitle;
  const AppBarComponent({super.key, this.isTitle = true});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: EdgeInsets.only(right: 5),

      title:
          isTitle
              ? Row(
                children: [
                  AppIcon(icon: Icons.auto_awesome_outlined, size: 26),
                  AppSpacing.w4,
                  Text(
                    "OneAI",
                    style: AppTextStyles.heading(context).copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
              : null,

      actions: [
        AppBarAction(
          onTap: () => {},
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.bolt, color: AppColors.innerBolt),
              Icon(Icons.bolt, color: AppColors.outerBolt, size: 19),
            ],
          ),
        ),
        AppSpacing.w4,
        AppBarAction(
          child: Row(
            children: [
              AppSpacing.w2,
              Text("GPT-4", style: AppTextStyles.subHeading(context)),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
