import 'package:flutter/material.dart';
import 'package:one_ai/model/chat_message_model.dart';

class ModelMessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  const ModelMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(message.message),
      ),
    );
  }
}
