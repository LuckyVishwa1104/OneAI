import 'package:flutter/material.dart';
import 'package:one_ai/screen/splash_screen/splash_screen_view_model.dart';
import 'package:one_ai/utility/components/common/wave_dots.ring.dart';
import 'package:one_ai/utility/constants/app_colors.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      onViewModelReady: (model) {
        model.runStartupLogic();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: WaveDotsRing(
              dotsPerLayer: 10,
              color: AppColors.primary,
              size: 240,
              child: ClipOval(
                child: Image.asset(
                  'assets/icons/one_ai_splash.png',
                  height: 72,
                  width: 72,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
