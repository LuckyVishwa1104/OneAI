import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/profile_option_model.dart';
import 'package:one_ai/services/auth/auth_service.dart';
import 'package:one_ai/utility/components/common/app_snackbar.dart';
import 'package:one_ai/utility/components/common/app_toggle.dart';
import 'package:one_ai/utility/components/common/logo_tile.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserProfileViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final AppSnackbar _snackbarService = locator<AppSnackbar>();

  void userProfile() {
    navigationService.navigateToSubscriptionView();
  }

  // Separate state for each toggle
  bool _isMemoryOn = false;
  bool _isChatHistoryOn = true;

  bool get isMemoryOn => _isMemoryOn;
  bool get isChatHistoryOn => _isChatHistoryOn;

  void toggleMemory(bool value) {
    _isMemoryOn = value;
    notifyListeners(); // rebuilds the view -> getter re-runs -> toggle updates
  }

  void toggleChatHistory(bool value) {
    _isChatHistoryOn = value;
    notifyListeners();
  }

  Future<void> logout() async {
    if (isBusy) return;

    setBusy(true);

    try {
      await _authService.signOut();

      await navigationService.clearStackAndShow(Routes.signupView);

      _snackbarService.show(message: 'Logged out successfully.');
      // show(message: 'Logged out successfully.');
    } catch (e) {
      _snackbarService.show(message: 'Unable to logout. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  List<ProfileOptionModel> get accountOption => [
    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.credit_card_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Manage Subscription",
      subtitle: "OneAI Pro",
      onTap: () {
        navigationService.navigateToSubscriptionView();
      },
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.lock_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Security",
      subtitle: "2FA enabled",
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.privacy_tip_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Data & Privacy",
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.link,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Connected Accounts",
      subtitle: "Google",
      onTap: () {},
    ),
  ];

  List<ProfileOptionModel> preferenceOptions = [
    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.dark_mode_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Appearance",
      subtitle: "Dark",
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.translate_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Language",
      subtitle: "English",
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.auto_awesome_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Default AI Model",
      subtitle: "Nova Flash",
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.notifications_none_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Notifications",
      subtitle: "All enabled",
      onTap: () {},
    ),
  ];

  List<ProfileOptionModel> get chatSettingOptions => [
    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.memory_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Memory",
      trailing: AppToggle(value: _isMemoryOn, onChanged: toggleMemory),

      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.history_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Chat History",
      trailing: AppToggle(
        value: _isChatHistoryOn,
        onChanged: toggleChatHistory,
      ),
      // Switch(value: true, onChanged: (value) {}),
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.inventory_2_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Archived Chats",
      subtitle: "3 chats",
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.tune_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Custom Instructions",
      onTap: () {},
    ),
  ];

  List<ProfileOptionModel> aboutOptions = [
    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.help_outline,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Help & Support",
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.chat_bubble_outline,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Send Feedback",
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.star_border_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Rate OneAI",
      onTap: () {},
    ),

    ProfileOptionModel(
      optionIcon: LogoTile(
        isLogo: false,
        icon: Icons.description_outlined,
        isCircular: true,
        iconSize: 24,
      ),
      title: "Privacy Policy & Terms",
      subtitle: "v1.0.0",
      onTap: () {},
    ),
  ];
}
