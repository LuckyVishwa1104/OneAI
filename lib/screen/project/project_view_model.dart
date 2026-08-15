import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/add_project_model.dart';
import 'package:one_ai/model/chat_item_model.dart';
import 'package:one_ai/model/chat_message_model.dart';
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

  ProjectViewModel() {
    searchController.addListener(notifyListeners);
  }

  final List<ProjectModel> _projects = [
    ProjectModel(
      id: 'proj_1',
      title: 'Website Redesign',
      chats: [
        ChatItemModel(
          id: 'chat_1_1',
          title: 'Homepage layout ideas',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
          projectId: 'proj_1',
          lastMessage: ChatMessageModel(
            message:
                'Here are three layout directions for the homepage hero section.',
            type: MessageType.assistant,
            createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          ),
        ),
        ChatItemModel(
          id: 'chat_1_2',
          title: 'Color palette suggestions',
          lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
          projectId: 'proj_1',
          lastMessage: ChatMessageModel(
            message: 'Can you suggest a palette that feels modern but warm?',
            type: MessageType.user,
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ),
        ChatItemModel(
          id: 'chat_1_3',
          title: 'Navbar responsiveness fix',
          lastUpdated: DateTime.now().subtract(const Duration(days: 3)),
          projectId: 'proj_1',
          lastMessage: ChatMessageModel(
            message:
                'The navbar collapses correctly now on mobile breakpoints.',
            type: MessageType.assistant,
            createdAt: DateTime.now().subtract(const Duration(days: 3)),
          ),
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
          projectId: 'proj_2',
          lastMessage: ChatMessageModel(
            message: 'Draft 3 short captions for the new product launch.',
            type: MessageType.user,
            createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          ),
        ),
        ChatItemModel(
          id: 'chat_2_2',
          title: 'Target audience research',
          lastUpdated: DateTime.now().subtract(const Duration(days: 2)),
          projectId: 'proj_2',
          lastMessage: ChatMessageModel(
            message:
                'Your core audience skews 25-34, mostly urban and mobile-first.',
            type: MessageType.assistant,
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
          ),
        ),
        ChatItemModel(
          id: 'chat_2_3',
          title: 'Email newsletter subject lines',
          lastUpdated: DateTime.now().subtract(const Duration(days: 4)),
          projectId: 'proj_2',
          lastMessage: ChatMessageModel(
            message: 'Give me 5 subject line options for the fall newsletter.',
            type: MessageType.user,
            createdAt: DateTime.now().subtract(const Duration(days: 4)),
          ),
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
          projectId: 'proj_3',
          lastMessage: ChatMessageModel(
            message:
                'Riverpod fits your use case better than plain Provider here.',
            type: MessageType.assistant,
            createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
          ),
        ),
        ChatItemModel(
          id: 'chat_3_2',
          title: 'API integration errors',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 8)),
          projectId: 'proj_3',
          lastMessage: ChatMessageModel(
            message:
                'Getting a 401 error when calling the refresh token endpoint.',
            type: MessageType.user,
            createdAt: DateTime.now().subtract(const Duration(hours: 8)),
          ),
        ),
        ChatItemModel(
          id: 'chat_3_3',
          title: 'Push notification setup',
          lastUpdated: DateTime.now().subtract(const Duration(days: 5)),
          projectId: 'proj_3',
          lastMessage: ChatMessageModel(
            message: 'FCM is now wired up for both Android and iOS targets.',
            type: MessageType.assistant,
            createdAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
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
          projectId: 'proj_4',
          lastMessage: ChatMessageModel(
            message:
                'Structure it around three themes: methodology, gaps, and impact.',
            type: MessageType.assistant,
            createdAt: DateTime.now().subtract(
              const Duration(days: 1, hours: 3),
            ),
          ),
        ),
        ChatItemModel(
          id: 'chat_4_2',
          title: 'Survey questionnaire draft',
          lastUpdated: DateTime.now().subtract(const Duration(days: 6)),
          projectId: 'proj_4',
          lastMessage: ChatMessageModel(
            message: 'Help me phrase these questions to avoid leading bias.',
            type: MessageType.user,
            createdAt: DateTime.now().subtract(const Duration(days: 6)),
          ),
        ),
        ChatItemModel(
          id: 'chat_4_3',
          title: 'Citation formatting help',
          lastUpdated: DateTime.now().subtract(const Duration(days: 9)),
          projectId: 'proj_4',
          lastMessage: ChatMessageModel(
            message:
                'Here is your reference list converted to APA 7th edition.',
            type: MessageType.assistant,
            createdAt: DateTime.now().subtract(const Duration(days: 9)),
          ),
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
          projectId: 'proj_5',
          lastMessage: ChatMessageModel(
            message:
                'Your discretionary spending went up 15% compared to last month.',
            type: MessageType.assistant,
            createdAt: DateTime.now().subtract(const Duration(hours: 12)),
          ),
        ),
        ChatItemModel(
          id: 'chat_5_2',
          title: 'Investment portfolio review',
          lastUpdated: DateTime.now().subtract(
            const Duration(days: 3, hours: 4),
          ),
          projectId: 'proj_5',
          lastMessage: ChatMessageModel(
            message:
                'Can you check if my portfolio is too weighted toward tech?',
            type: MessageType.user,
            createdAt: DateTime.now().subtract(
              const Duration(days: 3, hours: 4),
            ),
          ),
        ),
        ChatItemModel(
          id: 'chat_5_3',
          title: 'Tax deduction checklist',
          lastUpdated: DateTime.now().subtract(const Duration(days: 7)),
          projectId: 'proj_5',
          lastMessage: ChatMessageModel(
            message:
                'Here is a checklist of common deductions for freelancers.',
            type: MessageType.assistant,
            createdAt: DateTime.now().subtract(const Duration(days: 7)),
          ),
        ),
      ],
    ),
  ];

  List<QuickActionModel> getProjectOptions(ProjectModel project) {
    return [
      QuickActionModel(
        icon: project.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
        title: project.isPinned ? "Unpin Project" : "Pin Project",
        onTap: () {
          final index = _projects.indexWhere((p) => p.id == project.id);
          if (index != -1) {
            _projects[index] = project.copyWith(isPinned: !project.isPinned);
            notifyListeners();
          }
        },
      ),
      QuickActionModel(
        icon: Icons.message_outlined,
        title: "New Project Chat",
        onTap: () {
          final newChat = ChatItemModel(
            id: 'chat_${DateTime.now().millisecondsSinceEpoch}',
            title: 'New Chat',
            lastUpdated: DateTime.now(),
          );

          final index = _projects.indexWhere((p) => p.id == project.id);
          if (index != -1) {
            _projects[index] = project.copyWith(
              chats: [newChat, ...project.chats],
            );
            notifyListeners();
          }
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
              final index = _projects.indexWhere((p) => p.id == project.id);
              if (index != -1) {
                _projects[index] = project.copyWith(title: newName);
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
            _projects.removeWhere((p) => p.id == project.id);
            notifyListeners();
          }
        },
      ),
    ];
  }

  List<ProjectModel> get projects {
    final query = searchController.text.trim().toLowerCase();

    final filtered = _projects.where((project) {
      final matchesSearch =
          query.isEmpty || project.title.toLowerCase().contains(query);
      return matchesSearch;
    }).toList();

    filtered.sort((a, b) {
      if (a.isPinned == b.isPinned) return 0;
      return a.isPinned ? -1 : 1;
    });

    return filtered;
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

      _projects.insert(0, newProject);
      notifyListeners();
    }
  }

  void onProjectTapped(ProjectModel project) {
    navigationService.navigateToAllChatView(project: project);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
