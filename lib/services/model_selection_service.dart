import 'package:flutter/material.dart';
import 'package:one_ai/model/ai_model.dart';

class ModelSelectionService extends ChangeNotifier {
  static const List<AiModel> models = [
    // ================= OpenAI =================
    AiModel(
      id: 'gpt-4o',
      name: 'GPT-4o',
      description: 'Most capable',
      provider: 'OpenAI',
      tier: ModelTier.balanced,
      badge: ModelBadge.isNew,
      icon: Icons.workspace_premium_outlined,
    ),

    AiModel(
      id: 'gpt-4o-mini',
      name: 'GPT-4o mini',
      description: 'Fast & affordable',
      provider: 'OpenAI',
      tier: ModelTier.fast,
      icon: Icons.fast_forward_outlined,
    ),

    AiModel(
      id: 'gpt-4-turbo',
      name: 'GPT-4 Turbo',
      description: 'Advanced reasoning',
      provider: 'OpenAI',
      tier: ModelTier.balanced,
      badge: ModelBadge.pro,
      isLocked: true,
      icon: Icons.psychology_alt_outlined,
    ),

    AiModel(
      id: 'o1-preview',
      name: 'o1 Preview',
      description: 'Deep thinking',
      provider: 'OpenAI',
      tier: ModelTier.powerful,
      badge: ModelBadge.preview,
      isLocked: true,
      icon: Icons.flash_on_rounded,
    ),

    // ================= Google Gemini =================
    AiModel(
      id: 'gemini-2-flash',
      name: 'Gemini 2.0 Flash',
      description: 'Speed-optimised',
      provider: 'Google Gemini',
      tier: ModelTier.fast,
      badge: ModelBadge.isNew,
      icon: Icons.lightbulb_outlined,
    ),

    AiModel(
      id: 'gemini-1-5-pro',
      name: 'Gemini 1.5 Pro',
      description: 'Long context champion',
      provider: 'Google Gemini',
      tier: ModelTier.balanced,
      icon: Icons.book_outlined,
    ),

    AiModel(
      id: 'gemini-ultra',
      name: 'Gemini Ultra',
      description: 'Most powerful',
      provider: 'Google Gemini',
      tier: ModelTier.powerful,
      badge: ModelBadge.pro,
      isLocked: true,
      icon: Icons.stars_outlined,
    ),

    // ================= Anthropic =================
    AiModel(
      id: 'claude-3-5-sonnet',
      name: 'Claude 3.5 Sonnet',
      description: 'Balanced everyday model',
      provider: 'Anthropic',
      tier: ModelTier.balanced,
      badge: ModelBadge.isNew,
      icon: Icons.balance_rounded,
    ),

    AiModel(
      id: 'claude-3-opus',
      name: 'Claude 3 Opus',
      description: 'Most powerful',
      provider: 'Anthropic',
      tier: ModelTier.powerful,
      badge: ModelBadge.pro,
      isLocked: true,
      icon: Icons.rocket_outlined,
    ),
  ];

  List<AiModel> get topModels {
    final grouped = <String, List<AiModel>>{};

    for (final model in models) {
      grouped.putIfAbsent(model.provider, () => []).add(model);
    }

    return grouped.values.expand((models) => models.take(2)).toList();
  }

  static const Map<String, IconData> providerIcons = {
    'OpenAI': Icons.auto_awesome_outlined,
    'Google Gemini': Icons.diamond_outlined,
    'Anthropic': Icons.hub_outlined,
  };

  AiModel _selectedModel = models.first;
  AiModel get selectedModel => _selectedModel;

  void selectModel(AiModel model) {
    if (_selectedModel.id == model.id) return;
    _selectedModel = model;
    notifyListeners();
  }

  Map<String, List<AiModel>> get groupedByProvider {
    final Map<String, List<AiModel>> grouped = {};
    for (final model in models) {
      grouped.putIfAbsent(model.provider, () => []).add(model);
    }
    return grouped;
  }
}
