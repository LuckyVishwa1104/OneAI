import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/drawer_action.dart';
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
            // ==================================================
            // SECTION 1
            // ==================================================
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
                      color: AppColors.primary,
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

            // ==================================================
            // SCROLLABLE CONTENT
            // ==================================================
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ==========================================
                    // SECTION 2
                    // ==========================================
                    _sectionTitle(title: "Quick Actions", viewAll: false),

                    ...quickActions.map(
                      (actions) => _actionTile(
                        title: actions.title,
                        isProject: false,
                        icon: actions.icon,
                        isChat: false,
                      ),
                    ),

                    _actionTile(
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
                                  (action) => _actionTile(
                                    title: action.title,
                                    icon: action.icon,
                                    isProject: false,
                                    isChat: false,
                                  ),
                                )
                                .toList(),
                      ),
                    ),

                    // ==========================================
                    // SECTION 3 - PROJECTS
                    // ==========================================
                    _sectionTitle(title: "Projects", viewAll: true),

                    ...projects.map(
                      (project) => _actionTile(title: project, isProject: true, isChat: false),
                    ),

                    // ==========================================
                    // SECTION 4
                    // ==========================================
                    _sectionTitle(title: "Recent Chats",viewAll: true),

                    ...recentChats.map((chat) => _actionTile(isChat: true, title: chat, isProject: false)),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ==================================================
            // SECTION 5
            // ==================================================
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
                            style: AppTextStyles.subHeading,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle({required String title, required bool viewAll,}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: AppTextStyles.subHeading.copyWith(
                fontSize: 12,
                letterSpacing: 1.1,
              ),
            ),
            if (viewAll)
      const Icon(
        Icons.navigate_next,
        color: AppColors.primary,
      ),
          ],
        ),
      ),
    );
  }

  Widget _actionTile({
    IconData? icon,
    required String title,
    VoidCallback? onTap,
    required bool isProject,
    required bool isChat,
  }) {
    return ListTile(
      dense: true,
      leading: 
      isChat
        ? null
        : Icon(
            isProject ? Icons.folder_outlined : icon,
            color: AppColors.primary,
          ),
      title: Text(title, style: AppTextStyles.subHeading,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,),
      onTap: (){},
    );
  }
}

class QuickAction {
  final IconData icon;
  final String title;

  const QuickAction({required this.icon, required this.title});
}
