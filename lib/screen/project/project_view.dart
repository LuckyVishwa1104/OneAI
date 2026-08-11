import 'package:flutter/material.dart';
import 'package:one_ai/screen/project/project_view_model.dart';
import 'package:one_ai/utility/components/add_project_sheet.dart';
import 'package:one_ai/utility/components/app_bar/app_bar_component.dart';
import 'package:one_ai/utility/components/app_button.dart';
import 'package:one_ai/utility/components/logo_tile.dart';
import 'package:one_ai/utility/components/quick_action_menu.dart';
import 'package:one_ai/utility/components/search_bar_component.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';
import 'package:stacked/stacked.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectViewModel>.reactive(
      viewModelBuilder: () => ProjectViewModel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBarComponent(isAction: false, title: "Projects"),

          body: SafeArea(
            child: Padding(
              padding: AppSpacing.basePadding,
              child: Column(
                children: [
                  model.projects.isNotEmpty
                      ? SearchBarComponent(
                        controller: model.searchController,
                        leadingIcon: Icons.search_outlined,
                        hintText: "Search Project",
                      )
                      : SizedBox(),
                  AppSpacing.h8,

                  // here display porject if list is not empty else display new project widget
                  Expanded(
                    child:
                        model.projects.isNotEmpty
                            ? _buildProjectList(context, model)
                            : _buildEmptyView(context),
                  ),

                  // button to add new project
                  AppSpacing.h8,
                  AppButton(
                    onTap: model.onAddProjectTapped,
                    title: "Add Project",
                    icon: Icons.add,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // project list view widget
  Widget _buildProjectList(BuildContext context, ProjectViewModel model) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: model.projects.length,
      separatorBuilder: (_, __) => AppSpacing.h8,
      itemBuilder: (context, index) {
        final project = model.projects[index];
        final recentChat =
            project.chats.isNotEmpty ? project.chats.first : null;

        return Builder(
          builder: (BuildContext innerContext) {
            return InkWell(
              onTap: () {},
              onLongPress: () {
                QuickActionMenu.show(
                  context: innerContext,
                  actions: model.getProjectOptions(project),
                );
              },
              borderRadius: AppRadius.radiusMd,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    LogoTile(
                      height: 47,
                      width: 47,
                      icon: project.icon,
                      isLogo: false,
                    ),
                    AppSpacing.w12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading(
                              context,
                            ).copyWith(fontSize: 18),
                          ),
                          Text(
                            recentChat?.title ?? 'No chats yet',
                            style: AppTextStyles.subHeading(
                              context,
                            ).copyWith(fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Empty project list view
  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LogoTile(
            icon: Icons.folder_copy_outlined,
            isLogo: false,
            height: 80,
            width: 80,
            iconSize: 38,
          ),
          AppSpacing.h24,
          Text("No Projects Yet", style: AppTextStyles.heading(context)),
          AppSpacing.h8,
          Text(
            "Create projects to organize\nrelated chats and instructions.",
            textAlign: TextAlign.center,
            style: AppTextStyles.subHeading(context),
          ),
        ],
      ),
    );
  }
}
