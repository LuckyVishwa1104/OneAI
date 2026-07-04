import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/model_selection_service.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';
import 'package:stacked_services/stacked_services.dart';

class ModelPickerSheet extends StatelessWidget {
  const ModelPickerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ModelPickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final modelService = locator<ModelSelectionService>();
    final navigationService = locator<NavigationService>();

    return AnimatedBuilder(
      animation: modelService,
      builder: (context, _) {
        return SafeArea(
          child: Padding(
            padding: AppSpacing.defaultPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Text(
                  "Select a model",
                  style: AppTextStyles.heading(context).copyWith(fontSize: 20),
                ),
                AppSpacing.h12,
                ...ModelSelectionService.models.map((model) {
                  final isSelected = model.id == modelService.selectedModel.id;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(model.icon),
                    title: Text(
                      model.name,
                      style: AppTextStyles.subHeading(context).copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      model.description,
                      style: AppTextStyles.subHeading(context).copyWith(fontSize: 13),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                        : null,
                    onTap: () {
                      modelService.selectModel(model);
                      Navigator.pop(context);
                    },
                  );
                }),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.more_horiz),
                  title: Text(
                    "More models",
                    style: AppTextStyles.subHeading(context).copyWith(fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // navigationService.navigateToAllModelsView(); // add this route
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}