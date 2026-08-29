import 'package:flutter/material.dart';
import 'package:one_ai/utility/constants/constant.dart';

class AppBarAction extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  const AppBarAction({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusSm,
      child: Container(
        padding: AppSpacing.xxsPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppRadius.radiusSm,
          border: AppBorder.defaultBorder(context),
          boxShadow: [ AppShadow.actionContainer],
        ),
        child: child,
      ),
    );
  }
}
