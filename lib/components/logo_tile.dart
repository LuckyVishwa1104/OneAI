import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart' show AppRadius;

class LogoTile extends StatelessWidget {
  final double height;
  final double width;
  final IconData icon;
  final double iconSize;
  const LogoTile({
    super.key,
    this.height = 42,
    this.width = 42,
    this.iconSize = 25,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.radiusLg,
      ),

      child: Icon(
        icon,
        color: AppColors.appWhite,
        size: iconSize,
      ),
    );
  }
}
