import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/enums/snackbar_type.dart';
import 'package:one_ai/services/api/network/api_error_handler.dart';
import 'package:one_ai/services/auth/auth_service.dart';
import 'package:one_ai/utility/components/common/app_snackbar.dart';
import 'package:stacked/stacked.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dio/dio.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthProvider { google, apple }

class SignupViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final authService = locator<AuthService>();
  final AppSnackbar _snackbarService = locator<AppSnackbar>();

  final List<Color> rainbowColors = [
    Color(0xFFFFC9C9), // Pastel Red
    Color(0xFFFFD8A8), // Pastel Orange
    Color(0xFFFFF3BF), // Pastel Yellow
    Color(0xFFC3FAE8), // Mint Green
    Color(0xFFA5D8FF), // Sky Blue
    Color(0xFFD0BFFF), // Lavender Indigo
    Color(0xFFFFD6E7), // Soft Pink Violet
  ];

  final List<String> messages = [
    "You need only one AI",
    "Tailored for General use",
    "Tailored for Logic and Reasoning",
    "Tailored for Deep Research",
    "Manage all chats from single stream",
    "Start creating something New",
    "Let's Invent!",
  ];

  int _index = 0;
  int _charIndex = 0;
  String _displayedText = '';
  Timer? _typingTimer;
  Timer? _messageTimer;

  String get displayedText => _displayedText;
  Color get currentColor => rainbowColors[_index];

  AuthProvider? _activeProvider;
  AuthProvider? get activeProvider => _activeProvider;

  bool isLoadingFor(AuthProvider provider) =>
      isBusy && _activeProvider == provider;

  void init() {
    _startTypingEffect();
  }

  void navigateToManualAuth() {
    navigationService.navigateToManualAuthView();
  }

  Future<void> signInWithGoogle() async {
    if (isBusy) return;

    _activeProvider = AuthProvider.google;
    setBusy(true);

    try {
      final user = await authService.signInWithGoogle();

      if (user == null) {
        throw Exception('Google authentication did not return a user.');
      }

      _snackbarService.show(
        message: 'Welcome to OneAI!',
        type: SnackbarType.success,
      );

      await navigationService.clearStackAndShow(Routes.homeView);
    } on GoogleSignInException catch (e) {
      debugPrint('Google Sign-In error: ${e.code}');

      if (e.code != GoogleSignInExceptionCode.canceled) {
        _showError('Google sign-in failed. Please try again.');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth error: ${e.code}');
      _showError('Authentication failed. Please try again.');
    } on DioException catch (e) {
      debugPrint('Google backend authentication failed: $e');

      _showError(ApiErrorHandler.getMessage(e));
    } catch (e) {
      debugPrint('Google authentication flow failed: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      _activeProvider = null;
      setBusy(false);
    }
  }

  Future<void> signInWithApple() async {
    if (isBusy) return;

    _activeProvider = AuthProvider.apple;
    setBusy(true);

    try {
      await authService.signInWithApple();

      _snackbarService.show(
        message: 'Welcome to OneAI!',
        type: SnackbarType.success,
      );

      await navigationService.clearStackAndShow(Routes.homeView);
    } on SignInWithAppleAuthorizationException catch (e) {
      debugPrint('Apple Sign-In error: ${e.code}');

      if (e.code != AuthorizationErrorCode.canceled) {
        _showError('Apple sign-in failed. Please try again.');
      }
    } on DioException catch (e) {
      debugPrint('Apple backend authentication failed: $e');

      _showError(ApiErrorHandler.getMessage(e));
    } catch (e) {
      debugPrint('Apple authentication flow failed: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      _activeProvider = null;
      setBusy(false);
    }
  }

  void _showError(String message) {
    _snackbarService.show(message: message, type: SnackbarType.error);
  }

  void _startTypingEffect() {
    _typingTimer?.cancel();
    _charIndex = 0;
    _displayedText = '';
    notifyListeners();

    _typingTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_charIndex < messages[_index].length) {
        _displayedText += messages[_index][_charIndex];
        _charIndex++;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });

    _messageTimer = Timer(Duration(seconds: 4), () {
      _index = (_index + 1) % messages.length;
      _startTypingEffect();
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _messageTimer?.cancel();
    super.dispose();
  }
}
