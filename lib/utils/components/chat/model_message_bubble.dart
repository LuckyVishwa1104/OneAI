import 'package:flutter/material.dart';
import 'package:one_ai/model/chat_message_model.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/constants/app_constant.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class ModelMessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  const ModelMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: AppTextStyles.subHeading.copyWith(fontSize:15),
            ),
            AppSpacing.h4,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: AppIcon(icon: Icons.thumb_up_alt_outlined, size: AppConstant.base),
                ),

                AppSpacing.w8,

                InkWell(
                  onTap: () {},
                  child: AppIcon(icon: Icons.thumb_down_alt_outlined, size: AppConstant.base),
                ),

                AppSpacing.w8,

                InkWell(
                  onTap: () {},
                  child: AppIcon(icon: Icons.copy, size: AppConstant.base),
                ),

                AppSpacing.w8,

                InkWell(
                  onTap: () {},git
                  child: AppIcon(icon: Icons.refresh_rounded, size: AppConstant.base),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
