import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/services/auth/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dio/dio.dart';

enum AuthProvider { google, apple }

class SignupViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final authService = locator<AuthService>();
  final snackbarService = locator<SnackbarService>();

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
      await navigationService.clearStackAndShow(Routes.homeView);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        debugPrint('Google Sign-In code: ${e.code}');
        debugPrint('Google Sign-In description: ${e.description}');
        debugPrint('Google Sign-In details: ${e.details}');

        if (e.code == GoogleSignInExceptionCode.canceled) {
          debugPrint(
            'Credential Manager returned canceled. '
            'Check whether the flow was dismissed or misconfigured.',
          );
        } else {
          _showError('Google sign-in failed. Please try again.');
        }
      } else {
        debugPrint('Google Sign-In error: ${e.code}');
        _showError('Google sign-in failed. Please try again.');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth error: ${e.code}');
      _showError('Authentication failed. Please try again.');
    } on DioException catch (e) {
      debugPrint(
        'Backend authentication failed. '
        'Status: ${e.response?.statusCode}',
      );
      _showError(
        e.response?.statusCode == 401
            ? 'Google authentication was rejected. Please try again.'
            : 'Unable to connect to OneAI. Please try again.',
      );
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
      // TODO: replace with authService.signInWithApple()
      await Future.delayed(const Duration(seconds: 3));
      debugPrint('Apple Sign-In (placeholder) completed');

      // TODO: navigate on success
      // await navigationService.clearStackAndShow(Routes.homeView);
    } catch (e) {
      debugPrint('Apple authentication error: $e');
      _showError('Apple sign-in failed. Please try again.');
    } finally {
      _activeProvider = null;
      setBusy(false);
    }
  }

  void _showError(String message) {
    snackbarService.showSnackbar(message: message);
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
