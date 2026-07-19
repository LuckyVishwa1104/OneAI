import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/model/ai_model.dart';
import 'package:one_ai/services/model_selection_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ModelSelectViewModel extends BaseViewModel {
  final modelService = locator<ModelSelectionService>();
  final navigationService = locator<NavigationService>();

  Map<String, List<AiModel>> get groupedModels =>
      modelService.groupedByProvider;
  AiModel get selectedModel => modelService.selectedModel;

  AiModel? _expandedModel;
  AiModel? get expandedModel => _expandedModel;

  void selectModel(AiModel model) {
    modelService.selectModel(model);
    notifyListeners();
  }

  void toggleExpanded(AiModel model) {
    if (_expandedModel?.id == model.id) {
      _expandedModel = null;
    } else {
      _expandedModel = model;
    }

    notifyListeners();
  }

  void goBack() {
    navigationService.back();
  }
}
