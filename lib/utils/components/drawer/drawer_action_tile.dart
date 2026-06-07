import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class DrawerActionTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final bool isProject;
  final bool isChat;
  final VoidCallback? onTap;
  const DrawerActionTile({
    super.key,
    required this.title,
    this.icon,
    this.isProject = false,
    this.isChat = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minTileHeight: 36,
      visualDensity: const VisualDensity(vertical: -4),
      contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      leading:
          isChat
              ? null
              : 
              AppIcon(icon: isProject ? Icons.folder_outlined : icon!, ),
              
      title: Text(
        title,
        style: AppTextStyles.subHeading,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
