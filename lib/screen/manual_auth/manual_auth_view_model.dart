import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/enums/snackbar_type.dart';
import 'package:one_ai/services/api/user/user_api_service.dart';
import 'package:one_ai/services/auth/auth_service.dart';
import 'package:one_ai/utility/components/common/app_snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum ManualAuthMode { signup, login }

class ManualAuthViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final UserApiService _userApiService = locator<UserApiService>();
  final AppSnackbar _snackbarService = locator<AppSnackbar>();
  final NavigationService _navigationService = locator<NavigationService>();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ManualAuthMode _mode = ManualAuthMode.login;

  ManualAuthMode get mode => _mode;

  bool get isSignupMode => _mode == ManualAuthMode.signup;
  bool get isLoginMode => _mode == ManualAuthMode.login;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  void toggleMode() {
    if (isBusy) return;

    _mode = isSignupMode ? ManualAuthMode.login : ManualAuthMode.signup;

    formKey.currentState?.reset();

    nameController.clear();
    userIdController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    _obscurePassword = true;
    _obscureConfirmPassword = true;

    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  String? validateName(String? value) {
    if (!isSignupMode) return null;

    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }

    return null;
  }

  String? validateUserId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your User ID';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (!isSignupMode) return null;

    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  Future<void> submit() async {
    if (isBusy) return;

    FocusManager.instance.primaryFocus?.unfocus();

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (isSignupMode) {
      await createAccount();
    } else {
      await signIn();
    }
  }

  // ---------------- SIGNUP ----------------

  Future<void> createAccount() async {
    setBusy(true);

    try {
      await _userApiService.createUser(
        name: nameController.text.trim(),
        userId: userIdController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      _snackbarService.show(message: 'Account created successfully. Please sign in.', type: SnackbarType.success);

      // Preserve User ID for convenient signin.
      final registeredUserId = userIdController.text.trim();

      _mode = ManualAuthMode.login;

      formKey.currentState?.reset();

      nameController.clear();
      userIdController.text = registeredUserId;
      passwordController.clear();
      confirmPasswordController.clear();

      _obscurePassword = true;
      _obscureConfirmPassword = true;
    } catch (error) {
      _snackbarService.show(message: _getErrorMessage(error), type: SnackbarType.error,);
    } finally {
      setBusy(false);
    }
  }

  // ---------------- SIGNIN ----------------

  Future<void> signIn() async {
    setBusy(true);

    try {
      await _authService.signInWithPassword(
        userId: userIdController.text.trim(),
        password: passwordController.text,
      );

      _snackbarService.show(message: 'Welcome back!', type: SnackbarType.success);

      // Navigation will be added using your actual home route.
      await _navigationService.clearStackAndShow(Routes.homeView);
    } catch (error) {
      _snackbarService.show(message: _getErrorMessage(error), type: SnackbarType.error);
    } finally {
      setBusy(false);
    }
  }

  // ---------------- ERROR HANDLING ----------------

  String _getErrorMessage(Object error) {
    if (error is DioException) {
      final responseData = error.response?.data;

      if (responseData is Map) {
        final message = responseData['message'];

        if (message is String && message.isNotEmpty) {
          return message;
        }

        if (message is List && message.isNotEmpty) {
          return message.join('\n');
        }
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timed out. Please try again.';

        case DioExceptionType.connectionError:
          return 'Unable to connect to server. Check your internet connection.';

        default:
          return 'Something went wrong. Please try again.';
      }
    }

    return error.toString().replaceFirst('Exception: ', '');
  }

  @override
  void dispose() {
    nameController.dispose();
    userIdController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}
