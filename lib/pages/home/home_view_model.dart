import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/services/counter_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final counterService = locator<CounterService>();
  final navigationService = locator<NavigationService>();

  void navigateToCounter() {
    navigationService.navigateTo(Routes.counterView);
  }

  void addValues() {
    counterService.counterIncrease();
    rebuildUi();
  }
}
