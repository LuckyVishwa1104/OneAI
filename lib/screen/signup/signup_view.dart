import 'package:flutter/material.dart';
import 'package:one_ai/screen/signup/signup_view_model.dart';
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
                              child: AnimatedAiIcon(iconSize: 60),
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
                        borderRadius: AppConstant.xxxl,
                        onTap: model.isBusy ? null : model.signInWithGoogle,
                        title: 'Continue with Google',
                        expanded: true,
                        height: AppConstant.massive,
                        isPrimary: false,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        borderColor: Theme.of(context).dividerColor,
                        leading: Image.asset(
                          'assets/others/google.png',
                          width: 19,
                          height: 19,
                        ),
                        isLoading: model.isLoadingFor(AuthProvider.google),
                      ),
                      AppSpacing.h16,
                      AppButton(
                        onTap:
                            model.isBusy
                                ? null
                                : model
                                    .signInWithApple, // to be implemented later
                        title: 'Continue with Apple',
                        expanded: true,
                        borderRadius: AppConstant.xxxl,
                        height: AppConstant.massive,
                        isPrimary: false,
                        borderColor: Theme.of(context).dividerColor,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        leading: Image.asset(
                          'assets/others/apple.png',
                          width: 20,
                          height: 20,
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : null,
                        ),
                        isLoading: model.isLoadingFor(AuthProvider.apple),
                      ),
                      AppSpacing.h16,
                      AppButton(
                        onTap: model.isBusy ? null : model.navigateToManualAuth,
                        title: 'Continue with Email',
                        expanded: true,
                        borderRadius: AppConstant.xxxl,
                        height: AppConstant.massive,
                        isPrimary: true,
                        leading: const Icon(Icons.email_outlined),
                      ),
                      AppSpacing.h48,
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
