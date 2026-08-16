import 'package:flutter/material.dart';
import 'package:one_ai/app/app.locator.dart';
import 'package:one_ai/app/app.router.dart';
import 'package:one_ai/model/chat_message_model.dart';
import 'package:one_ai/model/drawer_action_model.dart';
import 'package:one_ai/utility/components/action_tile.dart';
import 'package:one_ai/utility/components/app_icon.dart';
import 'package:one_ai/utility/components/drawer/drawer_action_tile.dart';
import 'package:one_ai/utility/components/drawer/drawer_section_tile.dart';
import 'package:one_ai/utility/components/logo_tile.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:one_ai/model/enums/enum.dart';

class AppDrawer extends StatelessWidget {
  final bool showMoreActions;
  final List<DrawerActionModel> quickActions;
  final List<DrawerActionModel> moreQuickActions;
  final List<String> projects;
  final List<String> recentChats;
  final VoidCallback? moreTap;
  final VoidCallback profileTap;
  final VoidCallback newChat;

  const AppDrawer({
    super.key,
    required this.moreQuickActions,
    required this.projects,
    required this.quickActions,
    required this.recentChats,
    required this.showMoreActions,
    required this.moreTap,
    required this.profileTap,
    required this.newChat,
  });

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = locator<NavigationService>();

    // mock conversation list - remove after API connection
    final List<ChatMessageModel> mockConversation = [
      ChatMessageModel(
        message: 'Can you explain Provider vs Riverpod?',
        type: MessageType.user,
        createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
      ChatMessageModel(
        message:
            'Provider is simpler and built on InheritedWidget, while Riverpod '
            'is compile-safe, doesn\'t need BuildContext, and supports better '
            'testing and async state handling.',
        type: MessageType.assistant,
        createdAt: DateTime.now().subtract(const Duration(minutes: 11)),
      ),
      ChatMessageModel(
        message: 'Which one would you recommend for a mid-size app?',
        type: MessageType.user,
        createdAt: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      ChatMessageModel(
        message:
            'Riverpod, especially if you plan to scale — it avoids common '
            'Provider pitfalls like context lookup errors and makes state '
            'testable in isolation.',
        type: MessageType.assistant,
        createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
    ];

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Padding(
              padding: EdgeInsetsGeometry.only(
                left: 16,
                right: 16,
                bottom: 4,
                top: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "OneAI",
                    style: AppTextStyles.heading(
                      context,
                    ).copyWith(fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                  InkWell(
                    onTap: newChat,
                    child: ActionTile(
                      verticalPadding: 8,
                      child: Row(
                        children: [
                          Icon(
                            Icons.mode_edit_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          AppSpacing.w4,
                          Text(
                            "New",
                            style: AppTextStyles.subHeading(context).copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Quick Actions
                    DrawerSectionTile(title: "Quick Actions", viewAll: false),

                    ...quickActions.map(
                      (actions) => DrawerActionTile(
                        title: actions.title,
                        isProject: false,
                        icon: actions.icon,
                        isChat: false,
                        onTap: newChat,
                      ),
                    ),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child:
                          showMoreActions
                              ? Column(
                                key: const ValueKey('expanded'),
                                children:
                                    moreQuickActions
                                        .map(
                                          (action) => DrawerActionTile(
                                            title: action.title,
                                            icon: action.icon,
                                            isProject: false,
                                            isChat: false,
                                            onTap: newChat,
                                          ),
                                        )
                                        .toList(),
                              )
                              : DrawerActionTile(
                                key: const ValueKey('more'),
                                isProject: false,
                                isChat: false,
                                icon: Icons.expand_more,
                                title: "More",
                                onTap: moreTap,
                              ),
                    ),

                    // Projects
                    DrawerSectionTile(
                      title: "Projects",
                      viewAll: true,
                      onViewAll: () {
                        Navigator.of(context).pop();
                        navigationService.navigateToProjectView();
                      },
                    ),

                    ...projects.map(
                      (project) => DrawerActionTile(
                        title: project,
                        isProject: true,
                        isChat: false,
                        onTap: () {
                          Navigator.of(context).pop();
                          navigationService.navigateToAllChatView();
                        },
                      ),
                    ),

                    // Recent Chats
                    DrawerSectionTile(
                      title: "Recent Chats",
                      viewAll: true,
                      onViewAll: () {
                        Navigator.of(context).pop();
                        navigationService.navigateToAllChatView();
                      },
                    ),

                    ...recentChats.map(
                      (chat) => DrawerActionTile(
                        isChat: true,
                        title: chat,
                        isProject: false,
                        onTap: () {
                          Navigator.of(context).pop();
                          navigationService.navigateToChatView(
                            initialMessages: mockConversation,
                          );
                        },
                      ),
                    ),

                    AppSpacing.h2,
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        navigationService.navigateToAllChatView();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Load More Chats",
                            style: AppTextStyles.subHeading(context).copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          AppIcon(icon: Icons.navigate_next),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // User Profile
            InkWell(
              onTap: profileTap,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    LogoTile(
                      icon: Icons.person,
                      isLogo: false,
                      isCircular: true,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lucky Vishwakarma",
                            style: AppTextStyles.subHeading(context).copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            "OneAI Pro",
                            style: AppTextStyles.subHeading(
                              context,
                            ).copyWith(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    AppIcon(icon: Icons.navigate_next, size: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
