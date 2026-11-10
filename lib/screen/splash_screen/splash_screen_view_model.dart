import 'dart:async';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/services/token_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreenViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _tokenStorage = locator<TokenStorageService>();

  // Keep the splash visible long enough for the animation to be seen.
  static const _minSplashDuration = Duration(milliseconds: 2300);
  // Hard ceiling so a slow secure-storage read never traps the user.
  static const _sessionCheckTimeout = Duration(seconds: 3);

  Future<void> runStartupLogic() async {
    var isLoggedIn = false;

    try {
      final results = await Future.wait<Object?>([
        _checkSession().timeout(_sessionCheckTimeout),
        Future<void>.delayed(_minSplashDuration),
      ]);
      isLoggedIn = results.first as bool;
    } catch (_) {
      // Timeout or storage error: fall through to signup.
    }

    if (isLoggedIn) {
      await _navigationService.replaceWithHomeView();
    } else {
      await _navigationService.replaceWithSignupView();
    }
  }

  Future<bool> _checkSession() async {
    final token = await _tokenStorage.getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
