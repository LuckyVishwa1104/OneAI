import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/services/counter_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final counterService = locator<CounterService>();
  final navigationService = locator<NavigationService>();
  final TextEditingController promptController = TextEditingController();

  HomeViewModel() {
    promptController.addListener(() {
      notifyListeners();
    });
  }
  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  void sendPrompt(BuildContext context) {
    final prompt = promptController.text.trim();
    if (prompt.isEmpty) return;

    // navigationService.navigateTo(
    //   Routes.chatView,
    //   arguments: ChatViewArguments(
    //     prompt: prompt,
    //   ),
    // );

    navigationService.navigateTo(Routes.counterView);

    promptController.clear();
  }

  void navigateToCounter() {
    navigationService.navigateTo(Routes.counterView);
  }

  void addValues() {
    counterService.counterIncrease();
    rebuildUi();
  }
}
