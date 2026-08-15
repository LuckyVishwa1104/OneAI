import 'package:one_ai/model/chat_message_model.dart';

class ChatItemModel {
  final String id;
  final String title;
  final DateTime lastUpdated;
  final String? projectId;
  final ChatMessageModel? lastMessage;
  final bool isPinned;

  const ChatItemModel({
    required this.id,
    required this.title,
    required this.lastUpdated,
    this.projectId,
    this.lastMessage,
    this.isPinned = false,
  });

  ChatItemModel copyWith({
    String? id,
    String? title,
    DateTime? lastUpdated,
    String? projectId,
    ChatMessageModel? lastMessage,
    bool? isPinned,
  }) {
    return ChatItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      projectId: projectId ?? this.projectId,
      lastMessage: lastMessage ?? this.lastMessage,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
