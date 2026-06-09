import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class ThemeService with ListenableServiceMixin {
  static const _key = 'theme_mode';

  final _themeMode = ReactiveValue<ThemeMode>(ThemeMode.system);

  ThemeMode get themeMode => _themeMode.value;
  bool get isLight => _themeMode.value == ThemeMode.light;
  bool get isDark => _themeMode.value == ThemeMode.dark;
  bool get isSystem => _themeMode.value == ThemeMode.system;

  ThemeService() {
    listenToReactiveValues([_themeMode]);
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode.value = _fromString(prefs.getString(_key));
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _toString(mode));
  }

  ThemeMode _fromString(String? s) => switch (s) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  String _toString(ThemeMode m) => switch (m) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };
}
