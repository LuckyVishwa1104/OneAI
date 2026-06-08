import 'package:flutter/material.dart';
import 'package:one_ai/model/chat_message_model.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/constants/app_border.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_constant.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class UserMessageBubble extends StatefulWidget {
  final ChatMessageModel message;
  final bool isLastUserMessage;
  final VoidCallback? onEdit;
  const UserMessageBubble({
    super.key,
    required this.message,
    required this.isLastUserMessage,
    this.onEdit,
  });

  @override
  State<UserMessageBubble> createState() => _UserMessageBubbleState();
}

class _UserMessageBubbleState extends State<UserMessageBubble> {
  bool isExpanded = false;
  static const int maxLines = 10;

  bool _shouldShowExpandButton() {
    final span = TextSpan(
      text: widget.message.message,
      style: AppTextStyles.subHeading.copyWith(fontSize: 15),
    );

    final painter = TextPainter(
      text: span,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );

    painter.layout(maxWidth: 315);

    return painter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 315),
            margin: const EdgeInsets.symmetric(vertical: AppConstant.sm),
            padding: AppSpacing.defaultPadding,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.radiusXxl,
              border: AppBorder.defaultBorder,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message.message,
                  style: AppTextStyles.subHeading.copyWith(fontSize: 15),
                  maxLines: isExpanded ? null : maxLines,
                  overflow: TextOverflow.fade,
                ),

                if (_shouldShowExpandButton() || widget.isLastUserMessage) ...[
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_shouldShowExpandButton())
                        InkWell(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isExpanded ? 'Show less' : 'Show more',
                                style: AppTextStyles.subHeading.copyWith(
                                  fontSize: 14,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 2),
                              AppIcon(
                                icon:
                                    isExpanded
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down_rounded,
                              ),
                            ],
                          ),
                        )
                      else
                        const SizedBox(),

                      if (widget.isLastUserMessage)
                        InkWell(
                          onTap: widget.onEdit,
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: AppIcon(
                              icon: Icons.edit_outlined,
                              size: AppConstant.base,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
