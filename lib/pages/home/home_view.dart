import 'package:flutter/material.dart';
import 'package:one_ai/components/logo_tile.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
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
            title: Row(
              children: [
                Icon(Icons.auto_awesome, size: 28, color: AppColors.primary),
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

            backgroundColor: Colors.transparent,
            elevation: 0,

            actions: [
              InkWell(
                onTap: () => {},
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
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "GPT-4",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF334155),
                        ),
                      ),
                    ),

                    // AppSpacing.w2,
                    InkWell(
                      onTap: () => {},
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF64748B),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            actionsPadding: EdgeInsets.only(right: 5),
          ),

          drawer: Icon(Icons.grid_3x3),

          body: Center(
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
                  "Welcom Back!",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
                AppSpacing.h2,

                Text(
                  "How can I help you today?",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textSecondary,
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
