import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/chat_item_model.dart';
import 'package:one_ai/model/chat_message_model.dart';
import 'package:one_ai/model/project_model.dart';
import 'package:one_ai/model/quick_action_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:one_ai/model/enums/enum.dart';

class AllChatViewmodel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();
  final DialogService dialogService = locator<DialogService>();

  final TextEditingController searchController = TextEditingController();

  final ProjectModel? project;

  AllChatViewmodel({this.project}) {
    searchController.addListener(notifyListeners);
  }

  bool get isProjectScoped => project != null;

  String get appBarTitle => isProjectScoped ? (project!.title) : "Chats";

  final List<ChatItemModel> _chats = [
    ChatItemModel(
      id: 'c1',
      title: 'Flutter State Management',
      lastUpdated: DateTime.now().subtract(const Duration(minutes: 10)),
      projectId: 'p1',
      lastMessage: ChatMessageModel(
        message: 'Can you explain Provider vs Riverpod?',
        type: MessageType.user,
        createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
    ),
    ChatItemModel(
      id: 'c2',
      title: 'Trip to Japan Planning',
      lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
      lastMessage: ChatMessageModel(
        message: 'Here is a 7-day itinerary for Tokyo and Kyoto.',
        type: MessageType.assistant,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ),
    ChatItemModel(
      id: 'c3',
      title: 'Resume Review',
      lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
      projectId: 'p1',
      lastMessage: ChatMessageModel(
        message: 'Your experience section looks strong now.',
        type: MessageType.assistant,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ),
    ChatItemModel(
      id: 'c2',
      title: 'Trip to Japan Planning',
      lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
      lastMessage: ChatMessageModel(
        message: 'Here is a 7-day itinerary for Tokyo and Kyoto.',
        type: MessageType.assistant,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ),
    ChatItemModel(
      id: 'c3',
      title: 'Resume Review Feedback',
      lastUpdated: DateTime.now().subtract(const Duration(hours: 6)),
      lastMessage: ChatMessageModel(
        message: 'Your experience section could use stronger action verbs.',
        type: MessageType.assistant,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
    ),
    ChatItemModel(
      id: 'c4',
      title: 'Recipe Ideas for Dinner',
      lastUpdated: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      lastMessage: ChatMessageModel(
        message: 'What can I make with chicken, spinach, and pasta?',
        type: MessageType.user,
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      ),
    ),
    ChatItemModel(
      id: 'c5',
      title: 'Debugging Null Pointer Exception',
      lastUpdated: DateTime.now().subtract(const Duration(days: 2)),
      projectId: 'p3',
      lastMessage: ChatMessageModel(
        message:
            'The issue was an uninitialized controller in the widget tree.',
        type: MessageType.assistant,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ),
    ChatItemModel(
      id: 'c4',
      title: 'New Chat',
      lastUpdated: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  List<ChatItemModel> get chats {
    final query = searchController.text.trim().toLowerCase();

    // Source list: project's own chats if scoped, else the global mock list.
    final source = isProjectScoped ? project!.chats : _chats;

    final filtered =
        source.where((chat) {
          final matchesSearch =
              query.isEmpty || chat.title.toLowerCase().contains(query);
          return matchesSearch;
        }).toList();

    filtered.sort((a, b) {
      if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
      return b.lastUpdated.compareTo(a.lastUpdated);
    });

    return filtered;
  }

  List<QuickActionModel> getChatOptions(ChatItemModel chat) {
    return [
      QuickActionModel(
        icon: chat.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
        title: chat.isPinned ? "Unpin Chat" : "Pin Chat",
        onTap: () {
          final index = _chats.indexWhere((c) => c.id == chat.id);
          if (index != -1) {
            _chats[index] = chat.copyWith(isPinned: !chat.isPinned);
            // re-filter/re-sort so pinned chats reflect immediately
          }
          notifyListeners();
        },
      ),

      QuickActionModel(
        icon: Icons.edit_outlined,
        title: "Rename",
        onTap: () async {
          final response = await dialogService.showCustomDialog(
            variant: DialogType.rename,
            title: 'Rename Chat',
            description: chat.title,
          );

          if (response?.confirmed == true) {
            final newName = (response!.data as String?)?.trim();
            if (newName != null && newName.isNotEmpty) {
              final index = _chats.indexWhere((c) => c.id == chat.id);
              if (index != -1) {
                _chats[index] = chat.copyWith(title: newName);
                notifyListeners();
              }
            }
          }
        },
      ),

      QuickActionModel(
        icon: Icons.delete_outline,
        title: "Delete Chat",
        isDestructive: true,
        onTap: () async {
          final response = await dialogService.showCustomDialog(
            variant: DialogType.confirm,
            title: 'Delete Chat',
            description: 'Delete "${chat.title}"? This cannot be undone.',
            mainButtonTitle: 'Delete',
            secondaryButtonTitle: 'Cancel',
          );
          if (response?.confirmed == true) {
            _chats.removeWhere((c) => c.id == chat.id);
            // _applyFilters();
            notifyListeners();
          }
        },
      ),
    ];
  }

  final List<ChatMessageModel> mockConversation = [
    ChatMessageModel(
      message: 'Can you explain Provider vs Riverpod?',
      type: MessageType.user,
      createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
    ChatMessageModel(
      message:
          'Provider is simpler and built on InheritedWidget, while Riverpod '
          'is compile-safe, doesn\'t need BuildContext, and supports better '
          'testing and async state handling.',
      type: MessageType.assistant,
      createdAt: DateTime.now().subtract(const Duration(minutes: 11)),
    ),
    ChatMessageModel(
      message: 'Which one would you recommend for a mid-size app?',
      type: MessageType.user,
      createdAt: DateTime.now().subtract(const Duration(minutes: 9)),
    ),
    ChatMessageModel(
      message:
          'Riverpod, especially if you plan to scale — it avoids common '
          'Provider pitfalls like context lookup errors and makes state '
          'testable in isolation.',
      type: MessageType.assistant,
      createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    ChatMessageModel(
      message: 'Does Riverpod work well with code generation?',
      type: MessageType.user,
      createdAt: DateTime.now().subtract(const Duration(minutes: 6)),
    ),
    ChatMessageModel(
      message:
          'Yes — riverpod_generator lets you annotate providers with '
          '@riverpod and it generates the boilerplate for you, which keeps '
          'things concise as your app grows.',
      type: MessageType.assistant,
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatMessageModel(
      message:
          'Got it, thanks! One last thing — any tips for testing providers?',
      type: MessageType.user,
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    ChatMessageModel(
      message:
          'Use ProviderContainer in your tests to read and override providers '
          'directly, without needing a widget tree — it makes unit testing '
          'business logic much faster.',
      type: MessageType.assistant,
      createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];

  void navToNewChat() {
    navigationService.navigateToChatView(initialMessages: mockConversation);
  }

  void navToChatView() {
    navigationService.navigateToChatView();
  }

  void openChat(ChatItemModel chat) {
    // navigationService.navigateToChatView(chatId: chat.id);
  }

  @override
  void dispose() {
    searchController.removeListener(notifyListeners);
    searchController.dispose();
    super.dispose();
  }
}
