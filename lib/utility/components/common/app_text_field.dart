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

    final focusedBorder = Border.all(color: colorScheme.primary, width: 1.5);

    final errorBorder = Border.all(color: colorScheme.error, width: 1.2);

    final effectiveHint =
        isFocused
            ? (widget.focusedHintText ??
                (widget.hintText != null ? 'Enter ${widget.hintText}' : null))
            : widget.hintText;

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
                style: AppTextStyles.subHeading(
                  context,
                ).copyWith(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: effectiveHint,
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
                  hintStyle: AppTextStyles.subHeading(context),
                ),
              ),
            ),

            // Validation error
            if (hasError) ...[
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  field.errorText!,
                  style: TextStyle(color: colorScheme.error, fontSize: 12),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
