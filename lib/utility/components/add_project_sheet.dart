import 'package:flutter/material.dart';
import 'package:one_ai/model/add_project_model.dart';
import 'package:one_ai/utility/components/app_button.dart';
import 'package:one_ai/utility/components/app_text_field.dart';
import 'package:one_ai/utility/components/logo_tile.dart';
import 'package:one_ai/utility/constants/app_colors.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';
import 'package:stacked_services/stacked_services.dart';

class AddProjectSheet extends StatefulWidget {
  final SheetRequest request;
  final Function(SheetResponse response) completer;

  const AddProjectSheet({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  State<AddProjectSheet> createState() => _AddProjectSheetState();
}

class _AddProjectSheetState extends State<AddProjectSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _instructionController = TextEditingController();

  static const List<IconData> _iconOptions = [
    Icons.folder_outlined, // default
    Icons.code_outlined,
    Icons.lightbulb_outline,
    Icons.work_outline,
    Icons.school_outlined,
    Icons.rocket_launch_outlined,
    Icons.palette_outlined,
  ];

  IconData _selectedIcon = _iconOptions.first;

  @override
  void dispose() {
    _titleController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    if (_formKey.currentState!.validate()) {
      widget.completer(
        SheetResponse<AddProjectModel>(
          confirmed: true,
          data: AddProjectModel(
            title: _titleController.text.trim(),
            instructions: _instructionController.text.trim(),
            icon: _selectedIcon,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: AppRadius.radiusXxlTop,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:
                              Theme.of(context).brightness == Brightness.dark
                                  ? [
                                    AppColors.gradientSubtleDarkStart,
                                    AppColors.gradientSubtleDarkEnd,
                                  ]
                                  : [
                                    AppColors.gradientSubtleLightStart,
                                    AppColors.gradientSubtleLightEnd,
                                  ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  Text(
                    'New Project',
                    style: AppTextStyles.heading(
                      context,
                    ).copyWith(fontWeight: FontWeight.w400),
                  ),
                  AppSpacing.h20,

                  AppTextField(
                    controller: _titleController,
                    autofocus: true,
                    hintText: "Project Name",
                    validator:
                        (value) =>
                            (value == null || value.trim().isEmpty)
                                ? 'Project name is required'
                                : null,
                  ),
                  AppSpacing.h12,

                  AppTextField(
                    controller: _instructionController,
                    hintText: "Enter Instructions",
                    maxLines: 3,
                  ),
                  AppSpacing.h16,

                  Text('Icons', style: AppTextStyles.subHeading(context)),
                  AppSpacing.h8,

                  SizedBox(
                    height: 56,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _iconOptions.length,
                      separatorBuilder: (_, __) => AppSpacing.w12,
                      itemBuilder: (context, index) {
                        final iconData = _iconOptions[index];
                        final isSelected = iconData == _selectedIcon;

                        return InkWell(
                          onTap: () => setState(() => _selectedIcon = iconData),
                          borderRadius: BorderRadius.circular(24),
                          child: LogoTile(
                            height: 56,
                            width: 56,
                            icon: iconData,
                            isCircular: true,
                            isLogo: isSelected ? true : false,
                          ),
                        );
                      },
                    ),
                  ),
                  AppSpacing.h24,

                  AppButton(onTap: _handleCreate, title: "Create"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
