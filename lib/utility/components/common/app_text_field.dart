import 'package:flutter/material.dart';
import 'package:one_ai/utility/components/component.dart';
import 'package:one_ai/utility/constants/constant.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.focusedHintText,
    this.leadingIcon,
    this.trailing,
    this.maxLines = 1,
    this.autofocus = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.focusNode,
    this.height,
    this.borderRadius,
    this.contentPadding,
    this.enabled = true,
    this.readOnly = false,
  });

  final TextEditingController controller;

  // Hint and icons
  final String? hintText;
  final String? focusedHintText;
  final IconData? leadingIcon;
  final Widget? trailing;

  // Input configuration
  final int maxLines;
  final bool autofocus;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool readOnly;

  // Validation and callbacks
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  // Focus
  final FocusNode? focusNode;

  // Styling
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    _initializeFocusNode();
  }

  void _initializeFocusNode() {
    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.removeListener(_onFocusChanged);

      if (_ownsFocusNode) {
        _focusNode.dispose();
      }

      _initializeFocusNode();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);

    if (_ownsFocusNode) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isFocused = _focusNode.hasFocus;
    final radius = widget.borderRadius ?? AppRadius.radiusLg;

    final normalBorder = AppBorder.defaultBorder(context);

    final focusedBorder = Border.all(color: AppColors.primary, width: 1.5);

    final errorBorder = Border.all(color: colorScheme.error, width: 1.2);

    final effectiveHint =
        isFocused
            ? (widget.focusedHintText ??
                (widget.hintText != null ? 'Enter ${widget.hintText}' : null))
            : widget.hintText;

    final hintStyle = AppTextStyles.subHeading(
      context,
    ).copyWith(fontWeight: FontWeight.w400);

    final Widget? animatedHint =
        effectiveHint == null
            ? null
            : AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              // Keep the old and new hints left-aligned so they don't shift sideways
              layoutBuilder:
                  (currentChild, previousChildren) => Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  ),
              transitionBuilder:
                  (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.25),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
              child: Text(
                effectiveHint,
                key: ValueKey(effectiveHint),
                style: hintStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );

    return FormField<String>(
      initialValue: widget.controller.text,
      validator: widget.validator,
      enabled: widget.enabled,
      builder: (field) {
        final hasError = field.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: widget.height,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border:
                    hasError
                        ? errorBorder
                        : isFocused
                        ? focusedBorder
                        : normalBorder,
                borderRadius: radius,
                boxShadow: [AppShadow.homeTileShadow],
              ),
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                autofocus: widget.autofocus,
                maxLines: widget.obscureText ? 1 : widget.maxLines,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                onChanged: (value) {
                  field.didChange(value);
                  widget.onChanged?.call(value);
                },
                onSubmitted: widget.onFieldSubmitted,
                style: AppTextStyles.subHeading(context).copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  // hintText: effectiveHint,
                  hint: animatedHint, 
                  prefixIcon:
                      widget.leadingIcon != null
                          ? AppIcon(icon: widget.leadingIcon!)
                          : null,
                  suffixIcon: widget.trailing,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: widget.height != null,
                  contentPadding:
                      widget.contentPadding ??
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  hintStyle: AppTextStyles.subHeading(
                    context,
                  ).copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ),

            // Validation error
            if (hasError) ...[
              AppSpacing.h4,
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  field.errorText!,
                  style: AppTextStyles.subHeading(context).copyWith(
                    fontSize: AppConstant.md,
                    color: colorScheme.error,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
