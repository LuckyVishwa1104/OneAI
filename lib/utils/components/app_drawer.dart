import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/animated_ai_icon.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool showMoreActions = false;

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
                      color: AppColors.primary
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE0E7FF), Color(0xFFF3E8FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      // shape: BoxShape.rectangle,

                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit_document, color: AppColors.primary, size: 20,),
                        AppSpacing.w4,
                        Text("New", style: AppTextStyles.subHeading.copyWith(color: AppColors.primary)),
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
                    _sectionTitle("Quick Actions"),

                    _actionTile(icon: Icons.code, title: "Code"),

                    _actionTile(icon: Icons.image_outlined, title: "Image"),

                    _actionTile(
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
                        children: [
                          _actionTile(title : "Voice Chat", icon: Icons.settings_voice),
                          _actionTile(title : "Summarize", icon: Icons.summarize),
                          _actionTile(title : "Analyze PDF", icon: Icons.picture_as_pdf),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ==========================================
                    // SECTION 3
                    // ==========================================
                    _sectionTitle("Projects"),

                    ...projects.map((project) => _projectTile(project)),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("View All"),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ==========================================
                    // SECTION 4
                    // ==========================================
                    _sectionTitle("Recent Chats"),

                    ...recentChats.map((chat) => _chatTile(chat)),

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
                    LogoTile(icon: Icons.person, isLogo: false, isCircular: true,),

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
                            style: AppTextStyles.subHeading.copyWith(fontSize: 12),
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

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTextStyles.subHeading),
      onTap: onTap,
    );
  }

  Widget _subActionTile(String title) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 56, right: 16),
      title: Text(
        title,
        style: AppTextStyles.subHeading,
      ),
      onTap: () {},
    );
  }

  Widget _projectTile(String title) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.folder_outlined, color: Colors.amber),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {},
    );
  }

  Widget _chatTile(String title) {
    return ListTile(
      dense: true,
      leading: const Icon(
        Icons.chat_bubble_outline,
        size: 18,
        color: Colors.white70,
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {},
    );
  }
}
