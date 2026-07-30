import 'package:flutter/material.dart';

class ProjectModel {
  final String id;

  final String title;

  final String instructions;

  final IconData icon;

  final bool pinned;

  final int chatCount;

  final DateTime updatedAt;

  ProjectModel({
    required this.id,
    required this.title,
    required this.instructions,
    this.icon = Icons.folder_rounded,
    this.chatCount = 0,
    this.pinned = false,
    required this.updatedAt,
  });

  ProjectModel copyWith({
    String? title,
    String? instructions,
    IconData? icon,
    bool? pinned,
    int? chatCount,
    DateTime? updatedAt,
  }) {
    return ProjectModel(
      id: id,
      title: title ?? this.title,
      instructions: instructions ?? this.instructions,
      icon: icon ?? this.icon,
      pinned: pinned ?? this.pinned,
      chatCount: chatCount ?? this.chatCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}