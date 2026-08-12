import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:one_ai/model/chat_item_model.dart';

@immutable
class ProjectModel {
  final String id;
  final String title;
  final String? instructions;
  final IconData icon;
  final List<ChatItemModel> chats;
  final bool isPinned;

  const ProjectModel({
    required this.id,
    required this.title,
    this.instructions,
    this.icon = Icons.folder_outlined,
    required this.chats,
    this.isPinned = false,
  });

  ProjectModel copyWith({
    String? id,
    String? title,
    String? instructions,
    IconData? icon,
    List<ChatItemModel>? chats,
    bool? isPinned,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      instructions: instructions ?? this.instructions,
      icon: icon ?? this.icon,
      chats: chats ?? this.chats,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectModel &&
        other.id == id &&
        other.title == title &&
        other.instructions == instructions &&
        other.icon == icon &&
        other.isPinned == isPinned &&
        listEquals(other.chats, chats);
  }

  @override
  int get hashCode => Object.hash(id, title, instructions, icon, isPinned);
}