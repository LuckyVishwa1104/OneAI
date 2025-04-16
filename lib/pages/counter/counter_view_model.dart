import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/services/counter_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CounterViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final counterService = locator<CounterService>();

  void navigateToHome() {
    navigationService.navigateTo(Routes.homeView);
  }

  void addValue() {
    counterService.counterIncrease();
    rebuildUi();
  }
}
