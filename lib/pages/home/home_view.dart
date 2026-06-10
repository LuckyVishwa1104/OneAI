import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/animated_ai_icon.dart';
import 'package:one_ai/utils/components/app_bar/app_bar_component.dart';
import 'package:one_ai/utils/components/drawer/app_drawer.dart';
import 'package:one_ai/utils/components/home_tile.dart';
import 'package:one_ai/utils/components/prompt/prompt_input.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBarComponent(),

          drawer: AppDrawer(
            quickActions: model.quickActions,
            moreQuickActions: model.moreQuickActions,
            projects: model.projects,
            recentChats: model.recentChats,
            moreTap: model.showMore,
            showMoreActions: model.showMoreActions,
          ),

          body: Padding(
            padding: AppSpacing.largePadding,
            child: Column(
              children: [
                AnimatedAiIcon(iconSize: 50,),

                AppSpacing.h8,

                Text(
                  "Welcome Back!",
                  style: AppTextStyles.heading(context).copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Text(
                  "How can I help?",
                  style: AppTextStyles.subHeading(context).copyWith(fontSize: 20),
                ),

                AppSpacing.h20,

                Expanded(
                  child: ListView.separated(
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HomeTile(
                        logoIcon: model.listTiles[index].logoIcon,
                        title: model.listTiles[index].title,
                        subTitle: model.listTiles[index].subTitle,
                      );
                    },
                    separatorBuilder: (context, index) => AppSpacing.h12,
                    padding: EdgeInsets.zero,
                    itemCount: model.listTiles.length,
                  ),
                ),
              ],
            ),
          ),

          bottomNavigationBar: Padding(
            padding: AppSpacing.defaultPadding,
            child: PromptInput(
              promptText: model.promptController,
              onSendPrompt: () => model.sendPrompt(context),
              onAttachmentTap: () {},
              onMicTap: () {},
            ),
          ),
        );
      },
    );
  }
}
