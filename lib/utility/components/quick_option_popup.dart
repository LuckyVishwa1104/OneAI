import 'package:flutter/material.dart';
import 'package:one_ai/model/quick_action_model.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';

class QuickOptionPopup extends StatelessWidget {
  const QuickOptionPopup({super.key, required this.options});

  final List<QuickActionModel> options;

  /// Call this from any screen to show the popup
  static Future<void> show(
    BuildContext context,
    List<QuickActionModel> options,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => QuickOptionPopup(options: options),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: AppRadius.radiusMd,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSpacing.h8,
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            AppSpacing.h8,
            ...options.map((option) => _buildTile(context, option)),
            AppSpacing.h8,
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, QuickActionModel option) {
    final color = option.isDestructive ? Colors.red : null;
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        option.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(option.icon, color: color, size: 22),
            AppSpacing.w12,
            Text(
              option.title,
              style: AppTextStyles.subHeading(
                context,
              ).copyWith(fontSize: 16, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
