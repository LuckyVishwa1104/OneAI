import 'dart:async';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/services/token_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreenViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _tokenStorage = locator<TokenStorageService>();

  static const _minSplashDuration = Duration(milliseconds: 2300);
  static const _sessionCheckTimeout = Duration(seconds: 5);

  Future<void> runStartupLogic() async {
    final minSplash = Future<void>.delayed(_minSplashDuration);
    var isLoggedIn = false;

    try {
      isLoggedIn = await _checkSession().timeout(_sessionCheckTimeout);
    } catch (_) {
      // Timeout or storage error: treat as logged out.
    }

    // Honour the minimum splash time even on timeout/error.
    await minSplash;

    if (isLoggedIn) {
      await _navigationService.replaceWithHomeView();
    } else {
      await _navigationService.replaceWithSignupView();
    }
  }

  Future<bool> _checkSession() async {
    final token = await _tokenStorage.getAccessToken();

    if (_isTokenValid(token)) return true;

    // Token missing, malformed, or expired: clear the stale session.
    if (token != null) {
      await _tokenStorage.deleteAccessToken();
    }
    return false;
  }

  bool _isTokenValid(
    String? token, {
    Duration leeway = const Duration(seconds: 30),
  }) {
    if (token == null || token.isEmpty) return false;
    try {
      // Throws if the token is malformed or has no `exp` claim.
      final expiry = JwtDecoder.getExpirationDate(token);
      return expiry.isAfter(DateTime.now().add(leeway));
    } catch (_) {
      return false;
    }
  }
}