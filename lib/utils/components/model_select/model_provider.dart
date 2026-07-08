import 'package:flutter/material.dart';
import 'package:one_ai/model/ai_model.dart';
import 'package:one_ai/utils/components/model_select/model_row.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class ModelProvider extends StatelessWidget {
  final String provider;
  final List<AiModel> models;
  final AiModel selectedModel;
  final ValueChanged<AiModel> onSelect;

  const ModelProvider({
    super.key,
    required this.provider,
    required this.models,
    required this.selectedModel,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(provider, style: AppTextStyles.subHeading(context)),
        AppSpacing.h12,
        ...models.map(
          (m) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ModelRow(
              model: m,
              isSelected: m.id == selectedModel.id,
              onTap: () => onSelect(m),
            ),
          ),
        ),
        AppSpacing.h8,
      ],
    );
  }
}
