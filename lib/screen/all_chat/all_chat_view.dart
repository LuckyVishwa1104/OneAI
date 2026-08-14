import 'package:flutter/material.dart';
import 'package:one_ai/screen/all_chat/all_chat_viewmodel.dart';
import 'package:one_ai/utility/components/app_bar/app_bar_component.dart';
import 'package:one_ai/utility/components/app_button.dart';
import 'package:one_ai/utility/components/app_text_field.dart';
import 'package:one_ai/utility/constants/app_spacing.dart';
import 'package:stacked/stacked.dart';

class AllChatView extends StatelessWidget {
  const AllChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AllChatViewmodel>.reactive(
      viewModelBuilder: () => AllChatViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBarComponent(isAction: false, title: "All Chats"),
          body: SafeArea(
            child: Padding(
              padding: AppSpacing.basePadding,
              child: Column(
                children: [
                  AppTextField(
                    controller: model.searchController,
                    // focusNode: searchFocusNode,
                    leadingIcon: Icons.search,
                    hintText: 'Search projects',
                    height: 56,
                    borderRadius: BorderRadius.circular(30),
                  ),

                  Expanded(child: Container()),
                  AppButton(
                    onTap: () {
                      Navigator.of(context).pop();
                      model.navToNewChat();
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
}
