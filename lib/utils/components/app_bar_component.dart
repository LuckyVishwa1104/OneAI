import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/animated_ai_icon.dart';
import 'package:one_ai/utils/components/app_bar_action.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget{
  const AppBarComponent({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      actionsPadding: EdgeInsets.only(right: 5),

      title: Row(
        children: [
          AnimatedAiIcon(),
          SizedBox(width: 5),
          Text(
            "OneAI",
            style: AppTextStyles.heading.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),

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
              Padding(
                padding: const EdgeInsets.only(top: 3, bottom: 3, left: 7),
                child: Text("GPT-4", style: AppTextStyles.subHeading),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
