import 'package:flutter/material.dart';
import 'package:one_ai/model/project_model.dart';
import 'package:one_ai/screen/all_chat/all_chat_viewmodel.dart';
import 'package:one_ai/utility/components/app_bar/app_bar_component.dart';
import 'package:one_ai/utility/components/app_button.dart';
import 'package:one_ai/utility/components/app_icon.dart';
import 'package:one_ai/utility/components/app_text_field.dart';
import 'package:one_ai/utility/components/logo_tile.dart';
import 'package:one_ai/utility/components/quick_action_menu.dart';
import 'package:one_ai/utility/constants/app_radius.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:one_ai/utility/constants/app_text_styles.dart';
import 'package:stacked/stacked.dart';

class AllChatView extends StatelessWidget {
  final ProjectModel? project;

  const AllChatView({super.key, this.project});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AllChatViewmodel>.reactive(
      viewModelBuilder: () => AllChatViewmodel(project: project),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBarComponent(isAction: false, title: model.appBarTitle),
          body: SafeArea(
            child: Padding(
              padding: AppSpacing.basePadding,
              child: Column(
                children: [
                  model.chats.isNotEmpty
                      ? AppTextField(
                        controller: model.searchController,
                        leadingIcon: Icons.search,
                        hintText: 'Search chats',
                        height: 56,
                        borderRadius: BorderRadius.circular(30),
                      )
                      : SizedBox(),
                  AppSpacing.h12,

                  Expanded(
                    child:
                        model.chats.isNotEmpty
                            ? _buildChatList(context, model)
                            : _buildEmptyView(context),
                  ),

                  AppSpacing.h8,
                  AppButton(
                    onTap: () {
                      model.navToChatView();
                    },
                    title: "New Chat",
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

  // chat list view widget
  Widget _buildChatList(BuildContext context, AllChatViewmodel model) {
    return ListView.separated(
      itemCount: model.chats.length,
      separatorBuilder: (_, __) => AppSpacing.h8,
      itemBuilder: (context, index) {
        final chat = model.chats[index];
        return Builder(
          builder: (BuildContext innerContext) {
            return InkWell(
              onTap: model.navToNewChat,
              onLongPress: () {
                QuickActionMenu.show(
                  context: innerContext,
                  actions: model.getChatOptions(chat),
                );
              },
              borderRadius: AppRadius.radiusMd,
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 8, bottom: 8, left: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading(
                              context,
                            ).copyWith(fontSize: 18),
                          ),
                          Text(
                            chat.lastMessage?.message ?? "No messages yet",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.subHeading(
                              context,
                            ).copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    if (chat.isPinned) ...[
                      AppSpacing.w8,
                      AppIcon(icon: Icons.push_pin_outlined),
                    ],
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
            icon: Icons.message_outlined,
            isLogo: false,
            height: 65,
            width: 65,
            iconSize: 35,
          ),
          AppSpacing.h24,
          Text("No Chats Yet", style: AppTextStyles.heading(context)),
          AppSpacing.h8,
          Text(
            "Start a conversation to\nto get any kind of help and assistance!",
            textAlign: TextAlign.center,
            style: AppTextStyles.subHeading(context),
          ),
        ],
      ),
    );
  }
}
