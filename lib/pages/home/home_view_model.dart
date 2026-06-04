import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/drawer_action_model.dart';
import 'package:one_ai/model/home_tile_model.dart';
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
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  List<HomeTileModel> listTiles = [
    HomeTileModel(
      logoIcon: Icons.auto_awesome,
      title: "General Help",
      subTitle: "Ask me anything you need",
    ),
    HomeTileModel(
      logoIcon: Icons.lightbulb,
      title: "Creative Ideas",
      subTitle: "Help me brainstorm solution",
    ),
    HomeTileModel(
      logoIcon: Icons.code,
      title: "Code Assitant",
      subTitle: "Write, debug, or explain",
    ),
    HomeTileModel(
      logoIcon: Icons.image,
      title: "Design & Visual",
      subTitle: "Create UI dsign and layouts",
    ),
  ];

  bool showMoreActions = false;

  final List<DrawerActionModel> quickActions = [
    DrawerActionModel(icon: Icons.code, title: 'Code'),
    DrawerActionModel(icon: Icons.image_outlined, title: 'Image'),
  ];

  final List<DrawerActionModel> moreQuickActions = [
    DrawerActionModel(title: "Voice Chat", icon: Icons.mic_none_rounded),
    DrawerActionModel(title: "Summarize", icon: Icons.summarize_outlined),
    DrawerActionModel(
      title: "Analyze PDF",
      icon: Icons.picture_as_pdf_outlined,
    ),
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
}
