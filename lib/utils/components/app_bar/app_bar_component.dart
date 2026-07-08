import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/model_selection_service.dart';
import 'package:one_ai/utils/components/app_bar/app_bar_action.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/components/model_dropdown_overlay.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_constant.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool isAction;
  final bool showDefaultTitle;
  const AppBarComponent({
    super.key,
    this.title,
    this.showDefaultTitle = true,
    this.isAction = true,
  });

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarComponentState extends State<AppBarComponent> {
  final LayerLink _layerLink = LayerLink();

  @override
  void dispose() {
    ModelDropdownOverlay.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelService = locator<ModelSelectionService>();

    return AppBar(
      actionsPadding: EdgeInsets.only(right: 5),
      titleSpacing: AppConstant.xxs,
      title:
          widget.title != null
              ? Text(
                widget.title!,
                style: AppTextStyles.heading(
                  context,
                ).copyWith(fontSize: 25, fontWeight: FontWeight.w400),
              )
              : widget.showDefaultTitle
              ? Row(
                children: [
                  const AppIcon(icon: Icons.auto_awesome_outlined, size: 26),
                  AppSpacing.w4,
                  Text(
                    "OneAI",
                    style: AppTextStyles.heading(
                      context,
                    ).copyWith(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ],
              )
              : null,
      actions:
          widget.isAction
              ? [
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
                CompositedTransformTarget(
                  link: _layerLink,
                  child: AnimatedBuilder(
                    animation: modelService,
                    builder: (context, _) {
                      return AppBarAction(
                        onTap:
                            () => ModelDropdownOverlay.toggle(
                              context,
                              _layerLink,
                            ),
                        child: Row(
                          children: [
                            AppSpacing.w2,
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth:
                                    90, // Approx. width for ~10 characters
                              ),
                              child: Text(
                                modelService.selectedModel.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: AppTextStyles.subHeading(context),
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                              size: 24,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ]
              : null,
    );
  }
}
