import 'package:flutter/material.dart';
import 'package:one_ai/utility/components/dialogs/custom_dialog_box.dart';
import 'package:stacked_services/stacked_services.dart';

class RenameDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const RenameDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(
      title: request.title ?? 'Rename',
      showTextField: true,
      initialText: request.description,
      cancelText: 'Cancel',
      confirmText: 'Save',
      onConfirmWithText: (newName) {
        completer(DialogResponse(confirmed: true, data: newName.trim()));
      },
      onCancel: () {
        completer(DialogResponse(confirmed: false));
      },
    );
  }
}