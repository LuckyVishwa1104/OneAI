import 'package:flutter/material.dart';
import 'package:one_ai/screen/model_selection/model_select_view_model.dart';
import 'package:one_ai/utility/components/app_bar/app_bar_component.dart';
import 'package:one_ai/utility/components/model_select/model_provider.dart';
import 'package:one_ai/utility/components/model_select/model_row.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';
import 'package:stacked/stacked.dart';

class ModelSelectView extends StatelessWidget {
  const ModelSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ModelSelectViewModel>.reactive(
      viewModelBuilder: () => ModelSelectViewModel(),
      builder: (context, model, child) {
        final selected = model.selectedModel;

        return Scaffold(
          appBar: AppBarComponent(isAction: false, title: "AI Models"),

          body: Padding(
            padding: AppSpacing.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Currently Active",
                  style: AppTextStyles.subHeading(context),
                ),

                AppSpacing.h12,

                ModelRow(
                  model: selected,
                  isSelected: true,
                  isSelectedHeader: true,
                  isExpanded: false,
                  onExpand: () => {},
                ),

                AppSpacing.h12,

                Divider(color: Theme.of(context).dividerColor, thickness: 1.2),

                AppSpacing.h12,

                Expanded(
                  child: ListView(
                    children: [
                      ...model.groupedModels.entries.map((entry) {
                        return ModelProvider(
                          provider: entry.key,
                          models: entry.value,
                          selectedModel: selected,
                          expandedModel: model.expandedModel,
                          onSelect: model.selectModel,
                          onExpand: model.toggleExpanded,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
