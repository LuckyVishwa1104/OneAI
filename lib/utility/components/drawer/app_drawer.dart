import 'package:flutter/material.dart';
import 'package:one_ai/model/drawer_action_model.dart';
import 'package:one_ai/utility/components/action_tile.dart';
import 'package:one_ai/utility/components/app_icon.dart';
import 'package:one_ai/utility/components/drawer/drawer_action_tile.dart';
import 'package:one_ai/utility/components/drawer/drawer_section_tile.dart';
import 'package:one_ai/utility/components/logo_tile.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';

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
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "OneAI",
                    style: AppTextStyles.heading(
                      context,
                    ).copyWith(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  InkWell(
                    onTap: newChat,
                    child: ActionTile(
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

                    DrawerActionTile(
                      isProject: false,
                      isChat: false,
                      icon:
                          showMoreActions
                              ? Icons.expand_less
                              : Icons.expand_more,
                      title: "More",
                      onTap: moreTap,
                    ),

                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 250),
                      crossFadeState:
                          showMoreActions
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                      firstChild: const SizedBox.shrink(),
                      secondChild: Column(
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
                      ),
                    ),

                    // Projects
                    DrawerSectionTile(title: "Projects", viewAll: true),

                    DrawerActionTile(
                      title: "New Project",
                      isProject: false,
                      icon: Icons.add,
                      isChat: false,
                      onTap: () {},
                    ),

                    ...projects.map(
                      (project) => DrawerActionTile(
                        title: project,
                        isProject: true,
                        isChat: false,
                        onTap: () {},
                      ),
                    ),

                    // Recent Chats
                    DrawerSectionTile(title: "Recent Chats", viewAll: true),

                    ...recentChats.map(
                      (chat) => DrawerActionTile(
                        isChat: true,
                        title: chat,
                        isProject: false,
                        onTap: () {},
                      ),
                    ),

                    const SizedBox(height: 20),
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
