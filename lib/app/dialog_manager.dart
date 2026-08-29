import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/model/enums/bottom_sheet_type.dart';
import 'package:one_ai/model/enums/dialog_type.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:one_ai/utility/components/component.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.rename: (context, request, completer) =>
        RenameDialog(request: request, completer: completer),
    DialogType.confirm: (context, request, completer) =>
        ConfirmDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.addProject: (context, request, completer) =>
        AddProjectSheet(request: request, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

