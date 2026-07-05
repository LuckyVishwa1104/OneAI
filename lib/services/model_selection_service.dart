import 'package:flutter/material.dart';
import 'package:one_ai/model/ai_model.dart';

class ModelSelectionService extends ChangeNotifier{
  static const List<AiModel> models = [
    AiModel(id: 'gpt-4', name: 'GPT-4', description: 'Great for everyday tasks', icon: Icons.checklist_outlined),
    AiModel(id: 'gpt-4-turbo', name: 'GPT-4 Turbo', description: 'Faster, more capable', icon: Icons.rocket_outlined),
    AiModel(id: 'gpt-3.5', name: 'GPT-3.5', description: 'Quick and efficient', icon: Icons.speed),
    AiModel(id: 'claude-3', name: 'Claude 3', description: 'Great for writing', icon: Icons.edit_outlined),
    AiModel(id: 'gemini-pro', name: 'Gemini Pro', description: 'Multimodal reasoning', icon: Icons.diamond_outlined),
    AiModel(id: 'llama-3', name: 'Llama 3', description: 'Open source model', icon: Icons.hub_outlined),
    AiModel(id: 'mistral', name: 'Mistral Large', description: 'Efficient reasoning', icon: Icons.blur_on),
  ];

  AiModel _selectedModel = models.first;
  AiModel get selectedModel => _selectedModel;

  void selectModel(AiModel model) {
    if (_selectedModel.id == model.id) return;
    _selectedModel = model;
    notifyListeners();
  }
}

