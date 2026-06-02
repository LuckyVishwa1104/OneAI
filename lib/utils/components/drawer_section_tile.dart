import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class DrawerSectionTile extends StatelessWidget {
  final String title;
  final bool viewAll;
  final VoidCallback? onViewAll;
  const DrawerSectionTile({
    super.key,
    required this.title,
    this.viewAll = false,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: AppTextStyles.subHeading.copyWith(
                fontSize: 12,
                color: AppColors.textPrimary,
                letterSpacing: 1.1,
              ),
            ),
            if (viewAll)
              const Icon(Icons.navigate_next, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
