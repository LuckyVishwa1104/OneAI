import 'package:flutter/material.dart';
import 'package:one_ai/screen/splash_screen/splash_screen_view_model.dart';
import 'package:one_ai/utility/components/common/logo_tile.dart';
import 'package:one_ai/utility/components/common/wave_dots.ring.dart';
import 'package:one_ai/utility/constants/app_colors.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      // onViewModelReady: (model) {
      //   model.runStartupLogic();
      // },
      builder: (context, model, child) {
        return Scaffold(
          body: const Center(
            child: WaveDotsRing(
              color: AppColors.primary,
              size: 260,
              child: LogoTile(
                isLogo: true,
                icon: Icons.auto_awesome,
                isCircular: true,
                iconSize: 32,
                
              ),
            ),
          ),
        );
      },
    );
  }
}
