import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/components/prompt/prompt_action.dart';
import 'package:one_ai/utils/constants/app_border.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_shadow.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class PromptInput extends StatefulWidget {
  final TextEditingController promptText;
  final VoidCallback onSendPrompt;
  final VoidCallback onAttachmentTap;
  final VoidCallback onMicTap;
  
  // Added isHome boolean to toggle the animation
  final bool isHome;

  const PromptInput({
    super.key,
    required this.promptText,
    required this.onSendPrompt,
    required this.onAttachmentTap,
    required this.onMicTap,
    this.isHome = false, // Defaults to false
  });

  @override
  State<PromptInput> createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Controls the speed of the rotating gradient
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Only start the animation if we are on the Home screen
    if (widget.isHome) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant PromptInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Handle state changes if isHome is toggled dynamically
    if (widget.isHome && !_animationController.isAnimating) {
      _animationController.repeat();
    } else if (!widget.isHome && _animationController.isAnimating) {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We isolate the inner content (the text field, icons, etc.) so it 
    // doesn't rebuild 60 times a second during the animation.
    final Widget innerContent = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PromptAction(
          text: widget.promptText.text,
          icon: Icons.attach_file_rounded,
          onTap: widget.onAttachmentTap,
        ),
        AppSpacing.w8,
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 240, // approx 10 lines
            ),
            child: Scrollbar(
              child: TextField(
                controller: widget.promptText,
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                scrollPhysics: const BouncingScrollPhysics(),
                decoration: InputDecoration(
                  hintText: "Ask anything...",
                  hintStyle: AppTextStyles.subHeading(context),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        AppSpacing.w8,
        PromptAction(
          text: widget.promptText.text,
          icon: Icons.mic_none_rounded,
          onTap: widget.onMicTap,
        ),
        AppSpacing.w8,
        LogoTile(
          icon: Icons.arrow_upward_rounded,
          isCircular: true,
          iconSize: 24,
          onTap: widget.onSendPrompt,
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        maintainBottomViewPadding: false,
        child: widget.isHome
            ? _buildAnimatedBorder(context, innerContent)
            : _buildNormalBorder(context, innerContent),
      ),
    );
  }

  /// Builds the modern AI rotating gradient border
  Widget _buildAnimatedBorder(BuildContext context, Widget child) {
    final theme = Theme.of(context);
    
    return AnimatedBuilder(
      animation: _animationController,
      // The child (Row) is passed here so it DOES NOT rebuild on every tick
      child: child, 
      builder: (context, staticChild) {
        return Container(
          // 2.0 is the thickness of the animated border
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            borderRadius: AppRadius.radiusCirular,
            boxShadow: [AppShadow.homeTileShadow],
            // The magic happens here: A sweeping gradient that rotates
            gradient: SweepGradient(
              colors: [
                Color(0xFF7C3AED), // purple
                Color(0xFF06B6D4), // cyan
                Color(0xFF3B82F6), // blue
                Color(0xFF8B5CF6), // violet
              ],
              stops: const [0.0, 0.4, 0.8, 1.0],
              transform: GradientRotation(
                _animationController.value * 2 * math.pi,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              // We re-apply the radius to the inner container so the background 
              // doesn't clip over the animated gradient corners
              borderRadius: AppRadius.radiusCirular,
            ),
            child: staticChild,
          ),
        );
      },
    );
  }

  /// Builds the standard static border
  Widget _buildNormalBorder(BuildContext context, Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.radiusCirular,
        border: AppBorder.defaultBorder(context),
        boxShadow: [AppShadow.homeTileShadow],
      ),
      child: child,
    );
  }
}
