import 'package:one_ai/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreenViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

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

  void init() {
    _startTypingEffect();
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
