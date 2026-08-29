import 'package:flutter/material.dart';
import 'package:one_ai/utility/components/component.dart';

class ProfileOptionModel {
  final LogoTile optionIcon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const ProfileOptionModel({
    required this.optionIcon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });
}
