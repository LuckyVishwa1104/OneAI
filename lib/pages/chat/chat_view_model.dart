import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/model/chat_message_model.dart';
import 'package:one_ai/model/drawer_action_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  final TextEditingController promptController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  final List<ChatMessageModel> _messages = [];

  List<ChatMessageModel> get messages => _messages;

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

  ChatViewModel() {
    promptController.addListener(() {
      notifyListeners();
    });
  }

  void showMore() {
    showMoreActions = !showMoreActions;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> initialize(String prompt) async {
    promptController.text = prompt;
    await sendPrompt();
  }

  Future<void> sendPrompt() async {
    final prompt = promptController.text.trim();

    if (prompt.isEmpty) return;

    _messages.add(
      ChatMessageModel(
        message: prompt,
        type: MessageType.user,
        createdAt: DateTime.now(),
      ),
    );

    promptController.clear();

    _isLoading = true;
    notifyListeners();

    _scrollToBottom();

    try {
      /// Replace with your API call
      final response = await generateAiResponse(prompt);

      _messages.add(
        ChatMessageModel(
          message: response,
          type: MessageType.assistant,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      _messages.add(
        ChatMessageModel(
          message: "Something went wrong.",
          type: MessageType.assistant,
          createdAt: DateTime.now(),
        ),
      );
    }

    _isLoading = false;

    notifyListeners();

    _scrollToBottom();
  }

  Future<String> generateAiResponse(String prompt) async {
    await Future.delayed(const Duration(seconds: 2));

    return "AI Response for: $prompt";
  }

  int get lastUserMessageIndex {
    for (int i = messages.length - 1; i >= 0; i--) {
      if (messages[i].type == MessageType.user) {
        return i;
      }
    }

    return -1;
  }

  void editMessage(ChatMessageModel message) {
    promptController.text = message.message;

    promptController.selection = TextSelection.fromPosition(
      TextPosition(offset: message.message.length),
    );

    notifyListeners();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    promptController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
