import 'package:flutter/material.dart';
import 'package:one_ai/pages/chat/chat_view_model.dart';
import 'package:one_ai/utils/components/app_bar_component.dart';
import 'package:one_ai/utils/components/app_drawer.dart';
import 'package:one_ai/utils/components/chat/chat_bubble.dart';
import 'package:one_ai/utils/components/prompt_input.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:stacked/stacked.dart';

class ChatView extends StatelessWidget {
  final String initialPrompt;
  const ChatView({super.key, required this.initialPrompt});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ChatViewModel(),
      onViewModelReady: (model) {
        model.initialize(initialPrompt);
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBarComponent(isTitle: false),

          drawer: AppDrawer(
            quickActions: model.quickActions,
            moreQuickActions: model.moreQuickActions,
            projects: model.projects,
            recentChats: model.recentChats,
            moreTap: model.showMore,
            showMoreActions: model.showMoreActions,
          ),

          body: Column(
            children: [
              /// Chat Messages
              Expanded(
                child: ListView.builder(
                  controller: model.scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: model.messages.length + (model.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (model.isLoading && index == model.messages.length) {
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

              Padding(
                padding: AppSpacing.defaultPadding,
                child: PromptInput(
                  promptText: model.promptController,
                  onSendPrompt: model.sendPrompt,
                  onAttachmentTap: () {},
                  onMicTap: () {},
                  isHome: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
