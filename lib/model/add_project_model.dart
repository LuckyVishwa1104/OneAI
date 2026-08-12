import 'package:flutter/material.dart';

class AddProjectModel {
  final String title;
  final String? instructions;
  final IconData icon;

  const AddProjectModel({
    required this.title,
    this.instructions,
    required this.icon,
  });
}