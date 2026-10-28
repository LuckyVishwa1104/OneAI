import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/services/auth/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum ManualAuthMode { signup, login }

class ManualAuthViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ManualAuthMode _mode = ManualAuthMode.signup;
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

    if (isSignupMode && value.length < 8) {
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

  Future<void> createAccount() async {
    // Registration API integration will be added next.
    _snackbarService.showSnackbar(
      message: 'Registration API integration is next.',
    );
  }

  Future<void> signIn() async {
    // Login API integration will be added next.
    _snackbarService.showSnackbar(message: 'Login API integration is next.');
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
