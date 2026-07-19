import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/animated_ai_icon.dart';
import 'package:one_ai/utils/components/app_bar/app_bar_component.dart';
import 'package:one_ai/utils/components/drawer/app_drawer.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/components/prompt/prompt_input.dart';
import 'package:one_ai/utils/constants/app_constant.dart';
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
          appBar: AppBarComponent(
            tempChat: () {
              model.newChat();
            },
          ),

          drawer: AppDrawer(
            quickActions: model.quickActions,
            moreQuickActions: model.moreQuickActions,
            projects: model.projects,
            recentChats: model.recentChats,
            moreTap: model.showMore,
            showMoreActions: model.showMoreActions,
            profileTap: () {
              Navigator.pop(context);
              model.userProfile();
            },
            newChat: () {
              Navigator.pop(context);
              model.newChat();
            },
          ),

          body: Padding(
            padding: AppSpacing.largePadding,
            child: Column(
              children: [
                const Spacer(),

                AnimatedAiIcon(iconSize: 50),
                AppSpacing.h12,
                Text(
                  "Welcome ${model.userName}!",
                  style: AppTextStyles.heading(context).copyWith(fontSize: 24),
                ),
                AppSpacing.h8,
                Text(
                  model.starterMessage,
                  style: AppTextStyles.subHeading(
                    context,
                  ).copyWith(fontSize: 18),
                ),

                const Spacer(),

                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final item = model.quickChat[index];
                      return Row(
                        children: [
                          LogoTile(
                            icon: item.icon,
                            isLogo: false,
                            iconSize: 24,
                            isCircular: true,
                          ),
                          AppSpacing.w16,
                          Text(
                            item.text,
                            style: AppTextStyles.subHeading(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    },
                    physics: ScrollPhysics(),
                    separatorBuilder: (context, index) => AppSpacing.h20,
                    padding: EdgeInsets.zero,
                    itemCount: model.quickChat.length,
                  ),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.only(top: AppConstant.lg),
                  child: PromptInput(
                    isHome: true,
                    promptText: model.promptController,
                    onSendPrompt: () => model.sendPrompt(context),
                    onAttachmentTap: () {},
                    onMicTap: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
