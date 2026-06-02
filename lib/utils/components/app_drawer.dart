import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/drawer_action.dart';
import 'package:one_ai/utils/components/drawer_action_tile.dart';
import 'package:one_ai/utils/components/drawer_section_tile.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_constant.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool showMoreActions = false;

  final List<QuickAction> quickActions = [
    QuickAction(icon: Icons.code, title: 'Code'),
    QuickAction(icon: Icons.image_outlined, title: 'Image'),
  ];

  final List<QuickAction> moreQuickActions = [
    QuickAction(title: "Voice Chat", icon: Icons.mic_none_rounded),
    QuickAction(title: "Summarize", icon: Icons.summarize_outlined),
    QuickAction(title: "Analyze PDF", icon: Icons.picture_as_pdf_outlined),
  ];

  final List<String> projects = [
    "Flutter App",
    "AWS Serverless",
    "Amazon Interview",
  ];

  final List<String> recentChats = [
    "Flutter Drawer Design",
    "State Management",
    "AWS Authentication",
    "Angular CRUD",
    "Banking App",
    "Flutter Interview Prep",
    "Resume Improvements",
    "AWS S3 Storage",
    "Angular Components",
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
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
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  DrawerAction(
                    child: Row(
                      children: [
                        Icon(
                          Icons.mode_edit_outlined,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        AppSpacing.w4,
                        Text(
                          "New",
                          style: AppTextStyles.subHeading.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
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
                        onTap: (){},
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
                      onTap: () {
                        setState(() {
                          showMoreActions = !showMoreActions;
                        });
                      },
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
                                    onTap: (){},
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
                      onTap: (){},
                    ),

                    ...projects.map(
                      (project) => DrawerActionTile(
                        title: project,
                        isProject: true,
                        isChat: false,
                        onTap: (){},
                      ),
                    ),

                    // Recent Chats
                    DrawerSectionTile(title: "Recent Chats", viewAll: true),

                    ...recentChats.map(
                      (chat) => DrawerActionTile(
                        isChat: true,
                        title: chat,
                        isProject: false,
                        onTap: (){},
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // User Profile
            InkWell(
              onTap: () {
                // Navigate Profile
              },
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
                            style: AppTextStyles.subHeading.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            "Spike Plan",
                            style: AppTextStyles.subHeading.copyWith(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.navigate_next, color: AppColors.primary, size: 30,),
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

class QuickAction {
  final IconData icon;
  final String title;

  const QuickAction({required this.icon, required this.title});
}
