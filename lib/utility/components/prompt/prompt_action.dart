import 'package:flutter/material.dart';
import 'package:one_ai/utility/components/logo_tile.dart';

class PromptAction extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  const PromptAction({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isVisible = text.trim().isEmpty;

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: SizedBox(
        width: isVisible ? 40 : 0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isVisible ? 1 : 0,
          child: LogoTile(
            isLogo: false,
            icon: icon,
            isCircular: true,
            iconSize: 24,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
