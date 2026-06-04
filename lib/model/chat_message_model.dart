enum MessageType { user, assistant }

class ChatMessageModel {
  final String message;
  final MessageType type;
  final DateTime createdAt;

  ChatMessageModel({
    required this.message,
    required this.type,
    required this.createdAt,
  });
}
