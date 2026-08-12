import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/model/add_project_model.dart';
import 'package:one_ai/model/chat_item_model.dart';
import 'package:one_ai/model/enums/bottom_sheet_type.dart';
import 'package:one_ai/model/enums/dialog_type.dart';
import 'package:one_ai/model/project_model.dart';
import 'package:one_ai/model/quick_action_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProjectViewModel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();
  final DialogService dialogService = locator<DialogService>();
  final BottomSheetService bottomSheetService = locator<BottomSheetService>();

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

  List<QuickActionModel> getProjectOptions(ProjectModel project) {
    return [
      QuickActionModel(
        icon: Icons.push_pin_outlined,
        title: "Pin Project",
        onTap: () {
          projects.remove(project);
          projects.insert(0, project);

          notifyListeners();
        },
      ),
      QuickActionModel(
        icon: Icons.message_outlined,
        title: "New Project Chat",
        onTap: () {
          // todo : tobe impleemnted later
          // Creates a new chat and adds it to the top of the project's chat list
          final newChat = ChatItemModel(
            id: 'chat_${DateTime.now().millisecondsSinceEpoch}',
            title: 'New Chat',
            lastUpdated: DateTime.now(),
          );

          project.chats.insert(0, newChat);
          notifyListeners();
        },
      ),
      QuickActionModel(
        icon: Icons.edit_outlined,
        title: "Rename",
        onTap: () async {
          final response = await dialogService.showCustomDialog(
            variant: DialogType.rename,
            title: 'Rename Project',
            description: project.title,
          );

          if (response?.confirmed == true) {
            final newName = (response!.data as String?)?.trim();
            if (newName != null && newName.isNotEmpty) {
              final index = projects.indexWhere((p) => p.id == project.id);
              if (index != -1) {
                projects[index] = ProjectModel(
                  id: project.id,
                  title: newName,
                  chats: project.chats,
                );
                notifyListeners();
              }
            }
          }
        },
      ),
      QuickActionModel(
        icon: Icons.delete_outline,
        title: "Delete Project",
        isDestructive: true,
        onTap: () async {
          final response = await dialogService.showCustomDialog(
            variant: DialogType.confirm,
            title: 'Delete Project',
            description: 'Delete "${project.title}"? This cannot be undone.',
            mainButtonTitle: 'Delete',
            secondaryButtonTitle: 'Cancel',
          );
          if (response?.confirmed == true) {
            projects.removeWhere((p) => p.id == project.id);
            notifyListeners();
          }
        },
      ),
    ];
  }

  Future<void> onAddProjectTapped() async {
    final response = await bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addProject,
      isScrollControlled: true,
    );

    if (response?.confirmed == true) {
      final result = response!.data as AddProjectModel;

      final newProject = ProjectModel(
        id: 'proj_${DateTime.now().millisecondsSinceEpoch}',
        title: result.title,
        instructions: result.instructions,
        icon: result.icon,
        chats: [],
      );

      projects.insert(0, newProject);
      notifyListeners();
    }
  }

  Future initialise() async {
    setBusy(true);
    setBusy(false);
  }
}
