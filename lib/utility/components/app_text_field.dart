import 'package:flutter/material.dart';
import 'package:one_ai/utility/components/app_icon.dart';
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
    this.obscureText = false,
    this.focusNode,
    this.height,
    this.borderRadius,
    this.contentPadding,
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
  final bool obscureText;
  final FocusNode? focusNode;

  /// Fixed height for single-line uses like a search bar.
  /// Leave null for multi-line fields (e.g. instructions) that should size to content.
  final double? height;

  /// Defaults to [AppRadius.radiusLg]; pass a pill shape (e.g. BorderRadius.circular(30))
  /// for search-bar-style fields.
  final BorderRadius? borderRadius;

  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: AppBorder.defaultBorder(context),
        borderRadius: borderRadius ?? AppRadius.radiusLg,
        boxShadow: [AppShadow.homeTileShadow],
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        maxLines: obscureText ? 1 : maxLines,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        style: AppTextStyles.subHeading(
          context,
        ).copyWith(color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: leadingIcon != null ? AppIcon(icon: leadingIcon!) : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          isDense: height != null,
          contentPadding:
              contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintStyle: AppTextStyles.subHeading(context),
        ),
      ),
    );
  }
}
