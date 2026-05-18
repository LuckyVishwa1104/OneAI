import 'package:flutter/material.dart';
import 'package:one_ai/components/animated_ai_icon.dart';
import 'package:one_ai/components/home_tile.dart';
import 'package:one_ai/components/logo_tile.dart';
import 'package:one_ai/model/home_tile_model.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<HomeTileModel> listTiles = [
      HomeTileModel(
        logoIcon: Icons.lightbulb,
        title: "Creative Ideas",
        subTitle: "Help me brainstorm innovative solution",
      ),
      HomeTileModel(
        logoIcon: Icons.code,
        title: "Code Assitant",
        subTitle: "Write, debug, or explain",
      ),
      HomeTileModel(
        logoIcon: Icons.image,
        title: "Design & Visual",
        subTitle: "Create UI dsign and layouts",
      ),
      HomeTileModel(
        logoIcon: Icons.auto_awesome,
        title: "General Help",
        subTitle: "Ask me anything you need",
      ),
    ];

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(

            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            actionsPadding: EdgeInsets.only(right: 5),

            title: Row(
              children: [
                AnimatedAiIcon(),
                SizedBox(width: 5),
                Text(
                  "OneAI",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
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
                      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 7),
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
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
            
                Text(
                  "How can I help you today?",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textSecondary,
                  ),
                ),
            
                AppSpacing.h20,
            
                Expanded(
                  child: ListView.separated(
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HomeTile(
                        logoIcon: listTiles[index].logoIcon,
                        title: listTiles[index].title,
                        subTitle: listTiles[index].subTitle,
                      );
                    },
                    separatorBuilder: (context, index) => AppSpacing.h12,
                    padding: EdgeInsets.zero,
                    itemCount: listTiles.length,
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
