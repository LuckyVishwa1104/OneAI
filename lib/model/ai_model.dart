import 'package:flutter/material.dart';
import 'package:one_ai/model/enums/enum.dart';

class AiModel {
  final String id;
  final String name;
  final String description;
  final String provider; // "OpenAI", "Google Gemini", "Anthropic"
  final ModelTier tier;
  final ModelBadge badge;
  final bool isLocked; // true = requires Pro plan
  final IconData icon;
  final String extendedDescription;
  final List<String> capabilities;

  const AiModel({
    required this.id,
    required this.name,
    required this.description,
    required this.provider,
    required this.tier,
    required this.icon,
    this.badge = ModelBadge.none,
    this.isLocked = false,
    required this.extendedDescription,
    required this.capabilities,
  });
}