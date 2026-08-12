import 'package:flutter/material.dart';
import 'package:one_ai/utility/constants/app_border.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_shadow.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.leadingIcon,
    this.maxLines = 1,
    this.autofocus = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hintText;
  final IconData? leadingIcon;
  final int maxLines;
  final bool autofocus;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: AppBorder.defaultBorder(context),
        borderRadius: AppRadius.radiusLg,
        boxShadow: [AppShadow.homeTileShadow],
      ),
      child: TextFormField(
        controller: controller,
        autofocus: autofocus,
        maxLines: maxLines,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        style: AppTextStyles.subHeading(
          context,
        ).copyWith(color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: leadingIcon != null ? Icon(leadingIcon) : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: AppTextStyles.subHeading(context),
        ),
      ),
    );
  }
}
