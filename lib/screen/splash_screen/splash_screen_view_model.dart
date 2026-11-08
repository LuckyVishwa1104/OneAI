import 'dart:async';

import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreenViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Hard ceiling so a slow dependency never traps the user on the splash.
  static const _startupTimeout = Duration(seconds: 3);

  Future<void> runStartupLogic() async {
    var isLoggedIn = false;

    try {
      // Run critical startup tasks in parallel, not one after another.
      final results = await Future.wait<Object?>([
        _checkSession(),
        _loadRemoteConfig(),
        _initLocalStorage(),
      ]).timeout(_startupTimeout);

      isLoggedIn = results.first as bool;
    } on TimeoutException {
      // Continue anyway; the next screen can show its own loading state.
    } catch (_) {
      // Log to crash reporting here; fall through to the login flow.
    }

    if (isLoggedIn) {
      await _navigationService.replaceWithHomeView();
    } else {
      await _navigationService.replaceWithSignupView();
    }
  }

  // ---- Replace the stubs below with your real services ------------------

  Future<bool> _checkSession() async {
    // e.g. return _authService.hasValidSession();
    return false;
  }

  Future<void> _loadRemoteConfig() async {
    // e.g. await _remoteConfigService.fetch();
  }

  Future<void> _initLocalStorage() async {
    // e.g. await _localDb.init();
  }
}
