import 'package:flutter/material.dart';
import 'package:one_ai/pages/chat/chat_view_model.dart';
import 'package:one_ai/utils/components/animated_ai_icon.dart';
import 'package:one_ai/utils/components/app_bar/app_bar_component.dart';
import 'package:one_ai/utils/components/drawer/app_drawer.dart';
import 'package:one_ai/utils/components/chat/chat_bubble.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/components/prompt/prompt_input.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';
import 'package:stacked/stacked.dart';

class ChatView extends StatelessWidget {
  final String? initialPrompt;
  const ChatView({super.key, this.initialPrompt});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ChatViewModel(),
      onViewModelReady: (model) {
        model.initialize(initialPrompt);
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBarComponent(
            showDefaultTitle: false,
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

          body: Column(
            children: [
              /// Chat Messages
              Expanded(
                child:
                    model.messages.isEmpty
                        ? Column(
                          children: [
                            const Spacer(),

                            AnimatedAiIcon(iconSize: 50),
                            AppSpacing.h12,
                            Text(
                              "Welcome ${model.userName}!",
                              style: AppTextStyles.heading(
                                context,
                              ).copyWith(fontSize: 24),
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
                              child: ListView(
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                children:
                                    model.quickChat.entries.map((entry) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 20,
                                          left: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            LogoTile(
                                              icon: entry.key,
                                              isLogo: false,
                                              iconSize: 24,
                                              isCircular: true,
                                            ),
                                            AppSpacing.w16,
                                            Text(
                                              entry.value,
                                              style: AppTextStyles.subHeading(
                                                context,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ],
                        )
                        : ListView.builder(
                          controller: model.scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount:
                              model.messages.length + (model.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (model.isLoading &&
                                index == model.messages.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text("Thinking..."),
                              );
                            }

                            final message = model.messages[index];

                            return ChatBubble(
                              message: message,
                              isLastUserMessage:
                                  index == model.lastUserMessageIndex,
                              onEdit: () {
                                model.editMessage(message);
                              },
                            );
                          },
                        ),
              ),
            ],
          ),

          bottomNavigationBar: Padding(
            padding: AppSpacing.defaultPadding,
            child: PromptInput(
              promptText: model.promptController,
              onSendPrompt: model.sendPrompt,
              onAttachmentTap: () {},
              onMicTap: () {},
            ),
          ),
        );
      },
    );
  }
}
