import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_radius.dart';

class DrawerAction extends StatelessWidget {
  final Widget child;
  const DrawerAction({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0E7FF), Color(0xFFF3E8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.radiusCirular,
      ),
      child: child,
    );
  }
}
