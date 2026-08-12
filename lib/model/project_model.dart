import 'package:flutter/material.dart';
import 'package:one_ai/model/chat_item_model.dart';

class ProjectModel {
  final String id;
  String title;
  final String? instructions;
  final IconData icon;
  final List<ChatItemModel> chats;
  final bool isPinned;

  ProjectModel({
    required this.id,
    required this.title,
    this.instructions,
    this.icon = Icons.folder_outlined,
    required this.chats,
    this.isPinned = false,
  });
}
