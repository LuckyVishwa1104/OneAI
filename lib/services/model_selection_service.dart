import 'package:flutter/material.dart';
import 'package:one_ai/model/ai_model.dart';

class ModelSelectionService extends ChangeNotifier {
  static const List<AiModel> models = [
    // ================= OpenAI =================
    AiModel(
      id: 'gpt-4o',
      name: 'GPT-4o',
      description: 'Most capable',
      extendedDescription:
          'Best for complex reasoning, coding, writing, and multimodal tasks. Supports text, vision, and audio.',
      capabilities: ['Vision', 'Coding', 'Reasoning', 'Audio'],
      provider: 'OpenAI',
      tier: ModelTier.balanced,
      badge: ModelBadge.isNew,
      icon: Icons.workspace_premium_outlined,
    ),

    AiModel(
      id: 'gpt-4o-mini',
      name: 'GPT-4o mini',
      description: 'Fast & affordable',
      extendedDescription:
          'Optimized for everyday conversations, coding assistance, and quick responses with lower latency.',
      capabilities: ['Fast', 'Coding', 'Chat', 'Vision'],
      provider: 'OpenAI',
      tier: ModelTier.fast,
      icon: Icons.fast_forward_outlined,
    ),

    AiModel(
      id: 'gpt-4-turbo',
      name: 'GPT-4 Turbo',
      description: 'Advanced reasoning',
      extendedDescription:
          'Ideal for professional workflows requiring advanced reasoning, long conversations, and code generation.',
      capabilities: ['Reasoning', 'Coding', 'Long Context', 'Writing'],
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
      extendedDescription:
          'Designed for complex scientific, mathematical, and multi-step reasoning problems requiring deeper analysis.',
      capabilities: ['Deep Thinking', 'Math', 'Reasoning', 'Research'],
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
      extendedDescription:
          'Built for fast responses, everyday productivity, and multimodal conversations with low latency.',
      capabilities: ['Fast', 'Vision', 'Multimodal', 'Chat'],
      provider: 'Google Gemini',
      tier: ModelTier.fast,
      badge: ModelBadge.isNew,
      icon: Icons.lightbulb_outlined,
    ),

    AiModel(
      id: 'gemini-1-5-pro',
      name: 'Gemini 1.5 Pro',
      description: 'Long context champion',
      extendedDescription:
          'Excellent for analyzing lengthy documents, codebases, PDFs, and complex multimodal inputs.',
      capabilities: ['Long Context', 'Documents', 'Vision', 'Reasoning'],
      provider: 'Google Gemini',
      tier: ModelTier.balanced,
      icon: Icons.book_outlined,
    ),

    AiModel(
      id: 'gemini-ultra',
      name: 'Gemini Ultra',
      description: 'Most powerful',
      extendedDescription:
          'Google’s flagship model for advanced reasoning, multimodal understanding, and enterprise-grade tasks.',
      capabilities: ['Reasoning', 'Vision', 'Enterprise', 'Multimodal'],
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
      extendedDescription:
          'Great for writing, coding, analysis, and long conversations with natural, reliable responses.',
      capabilities: ['Writing', 'Coding', 'Analysis', 'Long Context'],
      provider: 'Anthropic',
      tier: ModelTier.balanced,
      badge: ModelBadge.isNew,
      icon: Icons.balance_rounded,
    ),

    AiModel(
      id: 'claude-3-opus',
      name: 'Claude 3 Opus',
      description: 'Quick response',
      extendedDescription:
          'Delivers fast, intelligent responses for creative writing, coding, and everyday productivity.',
      capabilities: ['Writing', 'Fast', 'Coding', 'Creative'],
      provider: 'Anthropic',
      tier: ModelTier.fast,
      badge: ModelBadge.pro,
      icon: Icons.speed_outlined,
    ),

    AiModel(
      id: 'claude-5-5-fable',
      name: 'Claude 5.5 Fable',
      description: 'Most powerful',
      extendedDescription:
          'Anthropic’s most capable model for advanced reasoning, complex coding, research, and enterprise workloads.',
      capabilities: ['Reasoning', 'Research', 'Coding', 'Enterprise'],
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
