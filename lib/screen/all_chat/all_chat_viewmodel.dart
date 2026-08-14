import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/chat_item_model.dart';
import 'package:one_ai/model/chat_message_model.dart';
import 'package:one_ai/model/enums/dialog_type.dart';
import 'package:one_ai/model/quick_action_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AllChatViewmodel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();
  final DialogService dialogService = locator<DialogService>();

  final TextEditingController searchController = TextEditingController();

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
      id: 'c4',
      title: 'New Chat',
      lastUpdated: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  // List<ChatItemModel> _filteredChats = [];
  List<ChatItemModel> get chats {
    final sorted = List<ChatItemModel>.from(_chats);
    sorted.sort((a, b) {
      if (a.isPinned != b.isPinned) {
        return a.isPinned ? -1 : 1; // pinned first
      }
      return b.lastUpdated.compareTo(a.lastUpdated); // then most recent first
    });
    return sorted;
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

  void navToNewChat() {
    navigationService.navigateToChatView();
  }

  void openChat(ChatItemModel chat) {
    // navigationService.navigateToChatView(chatId: chat.id);
  }

  @override
  void dispose() {
    // searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }
}
