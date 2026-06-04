import 'package:flutter/material.dart';
import 'package:one_ai/model/chat_message_model.dart';

class UserMessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  const UserMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(message.message),
      ),
    );
  }
}
