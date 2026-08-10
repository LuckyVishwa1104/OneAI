import 'package:flutter/material.dart';
import 'package:one_ai/utility/constants/app_border.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_shadow.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';

class CustomDialogBox extends StatefulWidget {
  final String title;
  final String? content;
  final String confirmText;
  final String? cancelText;
  final bool showTextField;
  final String? initialText;
  final ValueChanged<String>? onConfirmWithText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomDialogBox({
    super.key,
    required this.title,
    this.content,
    this.confirmText = 'OK',
    this.cancelText,
    this.showTextField = false,
    this.initialText,
    this.onConfirmWithText,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialText,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppRadius.radiusXxl,
          border: AppBorder.defaultBorder(context),
          boxShadow: [AppShadow.homeTileShadow],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: AppSpacing.xlPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: AppTextStyles.heading(context)),
                  if (widget.content != null) ...[
                    AppSpacing.h16,
                    Text(
                      widget.content!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.subHeading(context),
                    ),
                  ],
                  if (widget.showTextField) ...[
                    AppSpacing.h12,
                    TextField(
                      controller: _controller,
                      autofocus: true,
                      style: AppTextStyles.subHeading(context),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(color: Theme.of(context).dividerColor, height: 1.2),
            SizedBox(
              height: 48,
              child:
                  widget.onCancel == null && !widget.showTextField
                      ? InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onConfirm?.call();
                        },
                        child: Center(child: Text(widget.confirmText)),
                      )
                      : Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                              ),
                              onTap: () {
                                widget.onCancel?.call();
                              },
                              child: Center(
                                child: Text(
                                  widget.cancelText ?? 'Cancel',
                                  style: AppTextStyles.subHeading(context),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 1.2,
                            color: Theme.of(context).dividerColor,
                          ),
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(24),
                              ),
                              onTap: () {
                                if (widget.showTextField) {
                                  widget.onConfirmWithText?.call(
                                    _controller.text,
                                  );
                                } else {
                                  widget.onConfirm?.call();
                                }
                              },
                              child: Center(
                                child: Text(
                                  widget.confirmText,
                                  style: AppTextStyles.subHeading(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
