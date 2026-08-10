import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/model/chat_item_model.dart';
import 'package:one_ai/model/project_model.dart';
import 'package:one_ai/model/quick_action_model.dart';
import 'package:one_ai/utility/components/custom_dialog_box.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProjectViewModel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();

  final TextEditingController searchController = TextEditingController();

  final List<ProjectModel> projects = [
    ProjectModel(
      id: 'proj_1',
      title: 'Website Redesign',
      chats: [
        ChatItemModel(
          id: 'chat_1_1',
          title: 'Homepage layout ideas',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        ChatItemModel(
          id: 'chat_1_2',
          title: 'Color palette suggestions',
          lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
        ),
        ChatItemModel(
          id: 'chat_1_3',
          title: 'Navbar responsiveness fix',
          lastUpdated: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ],
    ),
    ProjectModel(
      id: 'proj_2',
      title: 'Marketing Campaign',
      chats: [
        ChatItemModel(
          id: 'chat_2_1',
          title: 'Instagram ad copy draft',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        ChatItemModel(
          id: 'chat_2_2',
          title: 'Target audience research',
          lastUpdated: DateTime.now().subtract(const Duration(days: 2)),
        ),
        ChatItemModel(
          id: 'chat_2_3',
          title: 'Email newsletter subject lines',
          lastUpdated: DateTime.now().subtract(const Duration(days: 4)),
        ),
      ],
    ),
    ProjectModel(
      id: 'proj_3',
      title: 'Mobile App Development',
      chats: [
        ChatItemModel(
          id: 'chat_3_1',
          title: 'State management approach',
          lastUpdated: DateTime.now().subtract(const Duration(minutes: 45)),
        ),
        ChatItemModel(
          id: 'chat_3_2',
          title: 'API integration errors',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 8)),
        ),
        ChatItemModel(
          id: 'chat_3_3',
          title: 'Push notification setup',
          lastUpdated: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ],
    ),
    ProjectModel(
      id: 'proj_4',
      title: 'Thesis Research',
      chats: [
        ChatItemModel(
          id: 'chat_4_1',
          title: 'Literature review outline',
          lastUpdated: DateTime.now().subtract(
            const Duration(days: 1, hours: 3),
          ),
        ),
        ChatItemModel(
          id: 'chat_4_2',
          title: 'Survey questionnaire draft',
          lastUpdated: DateTime.now().subtract(const Duration(days: 6)),
        ),
        ChatItemModel(
          id: 'chat_4_3',
          title: 'Citation formatting help',
          lastUpdated: DateTime.now().subtract(const Duration(days: 9)),
        ),
      ],
    ),
    ProjectModel(
      id: 'proj_5',
      title: 'Personal Finance',
      chats: [
        ChatItemModel(
          id: 'chat_5_1',
          title: 'Monthly budget breakdown',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 12)),
        ),
        ChatItemModel(
          id: 'chat_5_2',
          title: 'Investment portfolio review',
          lastUpdated: DateTime.now().subtract(
            const Duration(days: 3, hours: 4),
          ),
        ),
        ChatItemModel(
          id: 'chat_5_3',
          title: 'Tax deduction checklist',
          lastUpdated: DateTime.now().subtract(const Duration(days: 7)),
        ),
      ],
    ),
  ];

  List<QuickActionModel> getProjectOptions(
    ProjectModel project,
    BuildContext context,
  ) {
    return [
      QuickActionModel(
        // Optional: If your ProjectModel has an `isPinned` property, you can toggle the text/icon
        icon: Icons.push_pin_outlined,
        title: "Pin Project",
        onTap: () {
          // Removes the project from its current position and inserts it at the top
          projects.remove(project);
          projects.insert(0, project);

          // Note: If your ProjectModel has a boolean like `isPinned`, you would toggle it here instead:
          // project.isPinned = !project.isPinned;

          notifyListeners();
        },
      ),
      QuickActionModel(
        icon: Icons.message_outlined,
        title: "New Project Chat",
        onTap: () {
          // Creates a new chat and adds it to the top of the project's chat list
          final newChat = ChatItemModel(
            id: 'chat_${DateTime.now().millisecondsSinceEpoch}',
            title: 'New Chat',
            lastUpdated: DateTime.now(),
          );

          project.chats.insert(0, newChat);
          notifyListeners();
          // Optional: Navigate to the actual chat view right after creation
          // navigationService.navigateTo(Routes.chatView, arguments: newChat);
        },
      ),
      QuickActionModel(
        icon: Icons.edit_outlined,
        title: "Rename",
        onTap: () async {
          // Typically, you would use a DialogService here to prompt the user for a new name.
          // Example:
          // final response = await dialogService.showDialog(title: 'Rename Project');
          // if (response?.confirmed == true && response?.data != null) {
          //   project.title = response.data;
          //   notifyListeners();
          // }

          // Placeholder renaming logic for demonstration:
          // project.title = "${project.title} (Renamed)";
          showDialog(
            context: context,
            builder:
                (_) => CustomDialogBox(
                  title: 'Rename Project',
                  showTextField: true,
                  initialText: project.title,
                  cancelText: 'Cancel',
                  confirmText: 'Save',
                  onConfirmWithText: (newName) {
                    if (newName.trim().isNotEmpty) {
                      project.title = newName.trim();
                      notifyListeners();
                    }
                  },
                ),
          );
          notifyListeners();
        },
      ),
      QuickActionModel(
        icon: Icons.delete_outline,
        title: "Delete Project",
        isDestructive: true,
        onTap: () {
          // Removes the specific project from the master list
          projects.removeWhere((p) => p.id == project.id);
          notifyListeners();
        },
      ),
    ];
  }

  Future initialise() async {
    setBusy(true);

    // Load projects

    setBusy(false);
  }
}
