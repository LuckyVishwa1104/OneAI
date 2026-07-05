import 'package:flutter/material.dart';

class AiModel {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final bool isPro;

  const AiModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.isPro = false,
  });
}