import 'dart:math';

import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/drawer_action_model.dart';
import 'package:one_ai/model/home_tile_model.dart';
import 'package:one_ai/model/quick_chat.dart';
import 'package:one_ai/services/counter_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final counterService = locator<CounterService>();
  final navigationService = locator<NavigationService>();
  final TextEditingController promptController = TextEditingController();

  HomeViewModel() {
    promptController.addListener(() {
      notifyListeners();
    });
    starterMessage = starterMessages[Random().nextInt(starterMessages.length)];
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  late final String starterMessage;
  final String userName = "Lucky";

  final List<String> starterMessages = [
    "What can I help you with today?",
    "Ask me anything.",
    "Let's build something amazing.",
    "Ready when you are.",
    "How can I assist you today?",
    "Need help solving a problem?",
  ];

  bool showMoreActions = false;

  final List<DrawerActionModel> quickActions = [
    DrawerActionModel(icon: Icons.code, title: 'Code'),
    DrawerActionModel(icon: Icons.image_outlined, title: 'Image'),
  ];

  final List<DrawerActionModel> moreQuickActions = [
    DrawerActionModel(title: "Voice Chat", icon: Icons.mic_none_rounded),
    DrawerActionModel(title: "Summarize", icon: Icons.summarize_outlined),
    DrawerActionModel(title: "Analyze", icon: Icons.pie_chart_outline),
  ];

  final List<String> projects = [
    "Flutter App",
    "AWS Serverless",
    "Amazon Interview",
  ];

  final List<String> recentChats = [
    "Flutter Drawer Design",
    "State Management",
    "AWS Authentication",
    "Angular CRUD",
    "Banking App",
    "Flutter Interview Prep",
    "Resume Improvements",
    "AWS S3 Storage",
    "Angular Components",
  ];

  final List<QuickChat> quickChat = [
    QuickChat(
      icon: Icons.lightbulb_outline_rounded,
      text: "Generate ideas for projects.",
    ),
    QuickChat(
      icon: Icons.code_rounded,
      text: "Write, debug, and explain code.",
    ),
    QuickChat(
      icon: Icons.edit_note_rounded,
      text: "Draft emails, blogs, and content.",
    ),
  ];

  void sendPrompt(BuildContext context) {
    final prompt = promptController.text.trim();
    if (prompt.isEmpty) return;
    navigationService.navigateToChatView(initialPrompt: prompt);
    promptController.clear();
  }

  void showMore() {
    showMoreActions = !showMoreActions;
    notifyListeners();
  }

  void userProfile() async {
    navigationService.navigateToUserProfileView();
  }

  void newChat() async {
    navigationService.navigateToChatView();
  }
}
