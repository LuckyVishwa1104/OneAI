import 'package:flutter/material.dart';

class QuickActionModel {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const QuickActionModel({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });
}
