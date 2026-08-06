import 'package:flutter/material.dart';
import 'package:one_ai/model/chat_item_model.dart';

class ProjectModel {
  final String id;
  final String title;
  final IconData icon;
  final List<ChatItemModel> chats;

  const ProjectModel({
    required this.id,
    required this.title,
    this.icon = Icons.folder_outlined,
    required this.chats,
  });
}