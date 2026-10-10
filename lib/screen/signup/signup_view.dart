import 'package:flutter/material.dart';
import 'package:one_ai/screen/signup/signup_view_model.dart';
import 'package:one_ai/utility/components/app_loader.dart';
import 'package:stacked/stacked.dart';
import 'package:one_ai/utility/constants/constant.dart';
import 'package:one_ai/utility/components/component.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignupViewModel()..init(),
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
                                        style: AppTextStyles.heading(
                                          context,
                                        ).copyWith(
                                          fontSize: 28,
                                          color: AppColors.textPrimary,
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
                    color: Theme.of(context).scaffoldBackgroundColor,
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
                      AppButton(
                        onTap: model.isBusy ? null : model.signInWithGoogle,
                        title: 'Continue with Google',
                        expanded: true,
                        height: 50,
                        isPrimary: false,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        borderColor: Colors.grey.shade300,
                        leading: Image.asset(
                          'assets/icons/google.png',
                          width: 20,
                          height: 20,
                        ),
                        isLoading: model.isBusy,
                        loadingWidget:
                            const GradientCircularProgressIndicator(),
                      ),
                      SizedBox(height: 15),
                      AppButton(
                        onTap: model.isBusy ? null : () {},
                        title: 'Continue with Apple',
                        expanded: true,
                        height: 50,
                        isPrimary: false,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        leading: Image.asset(
                          'assets/icons/apple.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        isLoading: model.isBusy,
                        loadingWidget:
                            const GradientCircularProgressIndicator(),
                      ),
                      const SizedBox(height: 15),
                      // --- NEW EMAIL BUTTON ---
                      OutlinedButton.icon(
                        onPressed: () {
                          // Handle Email login navigation or action
                        },
                        icon: Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        label: const Text('Continue with Email'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          foregroundColor:
                              Theme.of(context).colorScheme.onSurface,
                          side: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
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
