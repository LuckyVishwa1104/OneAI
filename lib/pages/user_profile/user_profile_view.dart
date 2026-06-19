import 'package:flutter/material.dart';
import 'package:one_ai/pages/user_profile/user_profile_view_model.dart';
import 'package:one_ai/utils/components/profile/profile_card.dart';
import 'package:one_ai/utils/components/profile/profile_section.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:stacked/stacked.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.defaultPadding,
              child: Column(
                children: [
                  ProfileCard(
                    userName: "Lucky Vishwakarma",
                    email: "lucky@gmail.com",
                    planName: "OneAI Pro",
                    usedQueries: 68,
                    totalQueries: 100,
                  ),
                  AppSpacing.h16,
                  ProfileSection(
                    title: "Account",
                    options: model.accountOption,
                  ),

                  AppSpacing.h16,
                  ProfileSection(
                    title: "Preferences",
                    options: model.preferenceOptions,
                  ),

                  AppSpacing.h16,
                  ProfileSection(
                    title: "Chat Settings",
                    options: model.chatSettingOptions,
                  ),

                  AppSpacing.h16,
                  ProfileSection(title: "About", options: model.aboutOptions),

                  AppSpacing.h16,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
