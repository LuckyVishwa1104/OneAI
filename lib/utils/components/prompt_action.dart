import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/logo_tile.dart';

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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child:
          text.trim().isEmpty
              ? Row(
                key: const ValueKey("action_icon"),
                children: [
                  LogoTile(
                    isLogo: false,
                    icon: icon,
                    isCircular: true,
                    iconSize: 24,
                    onTap: onTap,
                  ),
                ],
              )
              : const SizedBox.shrink(),
    );
  }
}
