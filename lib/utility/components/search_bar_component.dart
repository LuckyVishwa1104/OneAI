import 'package:flutter/material.dart';
import 'package:one_ai/utility/components/app_icon.dart';
import 'package:one_ai/utility/constants/app_border.dart';
import 'package:one_ai/utility/constants/app_shadow.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';

class SearchBarComponent extends StatelessWidget {
  final TextEditingController controller;
  final IconData leadingIcon;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  const SearchBarComponent({
    super.key,
    required this.controller,
    required this.leadingIcon,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: AppBorder.defaultBorder(context),
        boxShadow: [AppShadow.homeTileShadow],
      ),
      child: Row(
        children: [
          AppSpacing.w16,
          AppIcon(icon: leadingIcon),
          AppSpacing.w8,
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: onChanged,
              style: AppTextStyles.subHeading(context).copyWith(fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.subHeading(context),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
