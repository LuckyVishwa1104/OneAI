import 'package:flutter/material.dart';
import 'package:one_ai/model/quick_action_model.dart';
import 'package:one_ai/utility/components/app_icon.dart';
import 'package:one_ai/utility/constants/app_border.dart';
import 'package:one_ai/utility/constants/app_colors.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_shadow.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';

class QuickActionMenu {
  static Future<void> show({
    required BuildContext context,
    required List<QuickActionModel> actions,
  }) async {
    // 1. Find the exact coordinates of the widget that was long-pressed
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    // 2. Define the position for the menu
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromLTWH(
        offset.dx + size.width / 2,
        offset.dy + size.height / 2,
        0,
        0,
      ),
      Offset.zero & MediaQuery.of(context).size,
    );

    // 4. Show the menu
    final selectedAction = await showMenu<QuickActionModel>(
      context: context,
      position: position,

      // Applying your decoration design parameters:
      color: Theme.of(context).colorScheme.surface,
      elevation: 8, // Fallback for shadow if shadowColor isn't enough
      shadowColor: AppShadow.homeTileShadow.color, // Map your shadow color here

      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusXxl,
        // side: borderSide, // Uncomment if you extract the BorderSide from AppBorder
        side: AppBorder.defaultBorderSide(context),
      ),

      // Build the items dynamically
      items:
          actions.map((action) {
            return PopupMenuItem<QuickActionModel>(
              value: action,
              child: Row(
                children: [
                  AppIcon(
                    icon: action.icon,
                    color: action.isDestructive ? AppColors.innerBolt : null,
                  ),

                  AppSpacing.w8,

                  Text(
                    action.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: action.isDestructive ? AppColors.innerBolt : Theme.of(context).colorScheme.onSurface,
                      fontSize: 15
                    )
                  ),
                ],
              ),
            );
          }).toList(),
    );

    // 5. Execute the callback if an action was tapped
    if (selectedAction != null) {
      selectedAction.onTap();
    }
  }
}
