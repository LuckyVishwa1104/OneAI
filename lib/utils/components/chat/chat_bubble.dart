import 'package:flutter/material.dart';
import 'package:one_ai/model/chat_message_model.dart';
import 'package:one_ai/utils/components/chat/model_message_bubble.dart';
import 'package:one_ai/utils/components/chat/user_message_bubble.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case MessageType.user:
        return UserMessageBubble(message: message);

      case MessageType.assistant:
        return ModelMessageBubble(message: message);
    }
  }
}
