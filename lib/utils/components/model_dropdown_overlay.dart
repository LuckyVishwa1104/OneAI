import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/model_selection_service.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/constants/app_border.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_shadow.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class ModelDropdownOverlay {
  static OverlayEntry? _entry;

  static bool get isOpen => _entry != null;

  static void toggle(BuildContext context, LayerLink layerLink) {
    if (_entry != null) {
      hide();
    } else {
      show(context, layerLink);
    }
  }

  static void show(BuildContext context, LayerLink layerLink) {
    final overlay = Overlay.of(context);
    final modelService = locator<ModelSelectionService>();
    final navigationService = locator<NavigationService>();

    _entry = OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            // Invisible barrier to catch outside taps and dismiss
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: hide,
                child: Container(color: Colors.transparent),
              ),
            ),
            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomRight,
              followerAnchor: Alignment.topRight,
              offset: const Offset(
                0,
                8,
              ), // small gap below the chip// shift left + drop below the anchor
              child: Align(
                alignment: Alignment.topRight,
                child: Material(
                  child: Container(
                    width: 280,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: AppRadius.radiusXxl,
                      border: AppBorder.defaultBorder(context),
                      boxShadow: [AppShadow.homeTileShadow],
                    ),
                    child: AnimatedBuilder(
                      animation: modelService,
                      builder: (context, _) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...ModelSelectionService.models.take(6).map((
                              model,
                            ) {
                              final isSelected =
                                  model.id == modelService.selectedModel.id;
                              return ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                leading: AppIcon(icon: model.icon),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.heading(
                                        context,
                                      ).copyWith(fontSize: 15),
                                    ),
                                    Text(
                                      model.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.subHeading(
                                        context,
                                      ).copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing:
                                    isSelected
                                        ? Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors:
                                                  Theme.of(context,).brightness == Brightness.dark ? 
                                                  [
                                                    AppColors.gradientSubtleDarkStart,
                                                    AppColors.gradientSubtleDarkEnd,
                                                  ] : 
                                                  [
                                                    AppColors.gradientSubtleLightStart,
                                                    AppColors.gradientSubtleLightEnd,
                                                  ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            shape: BoxShape.circle,

                                            // borderRadius: AppRadius.radiusMd,
                                          ),
                                          child: AppIcon(
                                            icon: Icons.check,
                                            size: 16,
                                          ),
                                        )
                                        : null,
                                onTap: () {
                                  modelService.selectModel(model);
                                  hide();
                                },
                              );
                            }),
                            Divider(
                              height: 8,
                              color: Theme.of(context).dividerColor,
                            ),
                            ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              leading: AppIcon(
                                icon: Icons.auto_awesome_outlined,
                              ),
                              title: Text(
                                "More models",
                                style: AppTextStyles.heading(
                                  context,
                                ).copyWith(fontSize: 15),
                              ),
                              onTap: () {
                                hide();
                                // navigationService.navigateToAllModelsView();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }
}
