import 'package:flutter/material.dart';

class AddProjectSheet extends StatefulWidget {
  const AddProjectSheet({super.key});

  @override
  State<AddProjectSheet> createState() => _AddProjectSheetState();
}

class _AddProjectSheetState extends State<AddProjectSheet> {
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
    final title = _titleController.text.trim();
    if (title.isEmpty) return; // simple guard, add error UI if you want

    Navigator.pop(context, {
      'title': title,
      'instructions': _instructionController.text.trim(),
      'icon': _selectedIcon,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // pushes content above the keyboard
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
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

            TextField(
              controller: _titleController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Project name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _instructionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Instructions (optional)',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Icon',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _iconOptions.map((iconData) {
                final isSelected = iconData == _selectedIcon;
                return InkWell(
                  onTap: () => setState(() => _selectedIcon = iconData),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade400,
                      ),
                    ),
                    child: Icon(
                      iconData,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
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
    );
  }
}