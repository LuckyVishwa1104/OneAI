import 'package:flutter/material.dart';

class SubscriptionPlan {
  final String id;
  final String title;
  final String subtitle;

  final IconData icon;

  final String price;
  final String duration;

  final bool isCurrent;
  final bool isSelected;

  final String? badge;

  final List<String> features;

  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.price,
    required this.duration,
    required this.features,
    this.badge,
    this.isCurrent = false,
    this.isSelected = false,
  });

  SubscriptionPlan copyWith({
    bool? isSelected,
  }) {
    return SubscriptionPlan(
      id: id,
      title: title,
      subtitle: subtitle,
      icon: icon,
      price: price,
      duration: duration,
      features: features,
      badge: badge,
      isCurrent: isCurrent,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}