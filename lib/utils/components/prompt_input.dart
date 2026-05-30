import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/components/prompt_action.dart';
import 'package:one_ai/utils/constants/app_border.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_shadow.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';

class PromptInput extends StatelessWidget {
  final TextEditingController promptText;
  final VoidCallback onSendPrompt;
  final VoidCallback onAttachmentTap;
  final VoidCallback onMicTap;
  const PromptInput({
    super.key,
    required this.promptText,
    required this.onSendPrompt,
    required this.onAttachmentTap,
    required this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        maintainBottomViewPadding: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.radiusXxlTop,
            border: Border(
              left: AppBorder.defaultBorderSide,
              right: AppBorder.defaultBorderSide,
              top: AppBorder.defaultBorderSide,
            ),
            boxShadow: [AppShadow.homeTileShadow],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PromptAction(
                text: promptText.text,
                icon: Icons.attach_file_rounded,
                onTap: onAttachmentTap,
              ),

              AppSpacing.w8,

              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 240, // تقريبًا 10 lines
                  ),
                  child: Scrollbar(
                    child: TextField(
                      controller: promptText,
                      minLines: 1,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,

                      scrollPhysics: const BouncingScrollPhysics(),

                      decoration: InputDecoration(
                        hintText: "Ask anything...",
                        hintStyle: TextStyle(color: AppColors.textSecondary),
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
                text: promptText.text,
                icon: Icons.mic_none_rounded,
                onTap: onMicTap,
              ),

              AppSpacing.w8,

              LogoTile(
                icon: Icons.arrow_upward_rounded,
                isCircular: true,
                iconSize: 24,
                onTap: onSendPrompt,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
