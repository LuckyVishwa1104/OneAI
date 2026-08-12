import 'package:flutter/material.dart';
import 'package:one_ai/utility/components/dialogs/custom_dialog_box.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ConfirmDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(
      title: request.title ?? 'Confirm',
      content: request.description,
      cancelText: request.secondaryButtonTitle ?? 'Cancel',
      confirmText: request.mainButtonTitle ?? 'Confirm',
      onConfirm: () => completer(DialogResponse(confirmed: true)),
      onCancel: () => completer(DialogResponse(confirmed: false)),
    );
  }
}