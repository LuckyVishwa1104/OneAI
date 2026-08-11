import 'package:flutter/material.dart';
import 'package:one_ai/model/add_project_model.dart';
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
    Icons.folder_copy_outlined, // default
    Icons.work_outline,
    Icons.school_outlined,
    Icons.lightbulb_outline,
    Icons.rocket_launch_outlined,
    Icons.code_outlined,
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
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              Text(
                'New Project',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Project name',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Project name is required'
                            : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _instructionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Instructions (optional)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),

              Text('Icon', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    _iconOptions.map((iconData) {
                      final isSelected = iconData == _selectedIcon;
                      return InkWell(
                        onTap: () => setState(() => _selectedIcon = iconData),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey.shade400,
                            ),
                          ),
                          child: Icon(
                            iconData,
                            color:
                                isSelected
                                    ? Colors.white
                                    : Colors.grey.shade700,
                            size: 22,
                          ),
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleCreate,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Create'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
