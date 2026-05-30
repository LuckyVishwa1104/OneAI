import 'package:flutter/material.dart';
import 'package:one_ai/utils/components/animated_ai_icon.dart';
import 'package:one_ai/utils/components/home_tile.dart';
import 'package:one_ai/utils/components/logo_tile.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_shadow.dart';
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
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            actionsPadding: EdgeInsets.only(right: 5),

            title: Row(
              children: [
                AnimatedAiIcon(),
                SizedBox(width: 5),
                Text(
                  "OneAI",
                  style: AppTextStyles.heading.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            actions: [
              InkWell(
                onTap: () => {},
                borderRadius: AppRadius.radiusSm,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppRadius.radiusSm,
                    border: Border.all(
                      color: const Color(0xFFDCE3ED),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // The "Border" - Darker yellow and slightly larger
                      Icon(
                        Icons.bolt,
                        color: Colors.amber[800], // Darker yellow/amber
                        // size: 64, // Slightly larger size for the outline effect
                      ),
                      // The "Fill" - Bright yellow and slightly smaller
                      Icon(
                        Icons.bolt,
                        color: Colors.yellow, // Bright yellow
                        size: 19,
                      ),
                    ],
                  ),
                ),
              ),

              AppSpacing.w4,

              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.radiusSm,
                  border: Border.all(
                    color: const Color(0xFFDCE3ED),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 3,
                        bottom: 3,
                        left: 7,
                      ),
                      child: Text(
                        "GPT-4",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                    // AppSpacing.w2,
                    InkWell(
                      onTap: () => {},
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textSecondary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          drawer: Icon(Icons.grid_3x3),

          body: Padding(
            padding: AppSpacing.largePadding,
            child: Column(
              children: [
                LogoTile(
                  icon: Icons.auto_awesome,
                  height: 62,
                  width: 62,
                  iconSize: 40,
                ),

                AppSpacing.h4,

                Text(
                  "Welcome Back!",
                  style: AppTextStyles.heading.copyWith(
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Text(
                  "How can I help?",
                  style: AppTextStyles.subHeading.copyWith(fontSize: 20),
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

          // bottom: MediaQuery.of(context).viewInsets.bottom + 6.0,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SafeArea(
              maintainBottomViewPadding: false,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.radiusXxlTop,
                  border: Border(
                    left: BorderSide(
                      color: const Color(0xFFE2E8F0),
                      width: 1.2,
                    ),
                    right: BorderSide(
                      color: const Color(0xFFE2E8F0),
                      width: 1.2,
                    ),
                    top: BorderSide(color: const Color(0xFFE2E8F0), width: 1.2),
                  ),
                  boxShadow: [AppShadow.homeTileShadow],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child:
                          model.promptController.text.trim().isEmpty
                              ? Row(
                                key: const ValueKey("attach"),
                                children: [
                                  LogoTile(
                                    isLogo: false,
                                    icon: Icons.attach_file_rounded,
                                    isCircular: true,
                                    iconSize: 24,
                                    onTap: () {},
                                  ),
                                ],
                              )
                              : const SizedBox.shrink(),
                    ),

                    AppSpacing.w8,

                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 240, // تقريبًا 10 lines
                        ),
                        child: Scrollbar(
                          child: TextField(
                            controller: model.promptController,
                            minLines: 1,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,

                            scrollPhysics: const BouncingScrollPhysics(),

                            decoration: InputDecoration(
                              hintText: "Ask anything...",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    AppSpacing.w8,

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),

                      child:
                          model.promptController.text.trim().isEmpty
                              ? Row(
                                key: const ValueKey("mic"),

                                children: [
                                  LogoTile(
                                    isLogo: false,
                                    icon: Icons.mic_none_rounded,
                                    isCircular: true,
                                    iconSize: 24,
                                    onTap: () {},
                                  ),
                                ],
                              )
                              : const SizedBox.shrink(),
                    ),

                    AppSpacing.w8,

                    LogoTile(
                      icon: Icons.arrow_upward_rounded,
                      isCircular: true,
                      iconSize: 24,
                      onTap: () => model.sendPrompt(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
