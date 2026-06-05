import 'package:flutter/material.dart';
import 'package:one_ai/model/chat_message_model.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/constants/app_border.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_constant.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';

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
  static const int maxLines = 15;

  bool _shouldShowExpandButton() {
    final span = TextSpan(
      text: widget.message.message,
      style: const TextStyle(fontSize: 14),
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
      child: Container(
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
              maxLines: isExpanded ? null : maxLines,
              overflow: TextOverflow.fade,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_shouldShowExpandButton())
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: AppIcon(
                      icon: isExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                  ),

                AppSpacing.w4,

                InkWell(
                  onTap: () {},
                  child: AppIcon(icon: Icons.copy, size: AppConstant.base),
                ),

                AppSpacing.w8,

                if (widget.isLastUserMessage)
                  InkWell(
                    onTap: widget.onEdit,
                    child: AppIcon(
                      icon: Icons.edit_outlined,
                      size: AppConstant.base,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
