import 'package:flutter/material.dart';

class QuickChat {
  final IconData icon;
  final String title;
  final String? subtitle;

  const QuickChat({
    required this.icon,
    required this.title,
    this.subtitle,
  });
}