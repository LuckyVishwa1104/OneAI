import 'package:flutter/material.dart';
import 'package:one_ai/components/logo_tile.dart' show LogoTile;
import 'package:one_ai/pages/home/home_view.dart';
import 'package:one_ai/pages/splash_screen/splash_screen_view_model.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplashScreenViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 4),
                curve: Curves.easeInOut,
                color: model.currentColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            // Center text in full area
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: model.displayedText,
                                        style: AppTextStyles.heading.copyWith(
                                          fontSize: 28,
                                        ),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          margin: const EdgeInsets.only(
                                            left: 5,
                                            bottom: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.appBlack,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // AI Icon positioned in upper half
                            Align(
                              alignment: Alignment(0, -0.45),
                              child: LogoTile(
                                icon: Icons.auto_awesome,
                                height: 62,
                                width: 62,
                                iconSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle Google login
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        },
                        icon: Icon(Icons.login, color: Colors.white),
                        label: Text('Continue with Google'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          minimumSize: Size(double.infinity, 50),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle Apple login
                        },
                        icon: Icon(Icons.apple, color: Colors.white),
                        label: Text('Continue with Apple'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 50),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
