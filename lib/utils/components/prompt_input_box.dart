import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';

class PromptInputBox extends StatelessWidget {
  final TextEditingController promptText;
  final VoidCallback onSendPrompt;
  final VoidCallback onAttachmentTap;
  final VoidCallback onMicTap;
  const PromptInputBox({
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
        left: 16,
        right: 16,
        // top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: onAttachmentTap,
                  icon: const Icon(Icons.attach_file_rounded),
                ),
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
                        hintStyle: TextStyle(color: Colors.grey.shade500),
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

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),

                child:
                    promptText.text.trim().isEmpty
                        ? Row(
                          key: const ValueKey("mic"),

                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: onMicTap,
                                icon: const Icon(Icons.mic_none_rounded),
                              ),
                            ),

                            AppSpacing.w8,
                          ],
                        )
                        : const SizedBox.shrink(),
              ),

              AppSpacing.w8,

              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: onSendPrompt,
                  icon: const Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
