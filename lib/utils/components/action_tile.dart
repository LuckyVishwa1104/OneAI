import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';

class ActionTile extends StatelessWidget {
  final Widget child;
  final double verticalPadding;
  const ActionTile({super.key, required this.child, this.verticalPadding = 10.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: verticalPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              Theme.of(context).brightness == Brightness.dark
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
        borderRadius: AppRadius.radiusCirular,
      ),
      child: child
    );
  }
}
