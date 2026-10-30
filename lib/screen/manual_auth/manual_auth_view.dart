import 'package:flutter/material.dart';
import 'package:one_ai/screen/manual_auth/manual_auth_view_model.dart';
import 'package:one_ai/utility/components/component.dart';
import 'package:one_ai/utility/constants/constant.dart';
import 'package:stacked/stacked.dart';

class ManualAuthView extends StatelessWidget {
  const ManualAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ManualAuthViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppSpacing.h24,

                    AnimatedAiIcon(iconSize: 60),
                    AppSpacing.h20,

                    Text(
                      model.isSignupMode ? 'One app for AI' : 'Welcome back',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading(
                        context,
                      ).copyWith(fontSize: 24),
                    ),
                    AppSpacing.h8,

                    Text(
                      model.isSignupMode
                          ? 'Create an account to get started with OneAI.'
                          : 'Sign in to continue to OneAI.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subHeading(
                        context,
                      ).copyWith(fontSize: 18),
                    ),

                    AppSpacing.h32,

                    if (model.isSignupMode) ...[
                      AppTextField(
                        controller: model.nameController,
                        hintText: 'Name',
                        focusedHintText: 'Enter your full name',
                        leadingIcon: Icons.person_outline,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: model.validateName,
                      ),
                      const SizedBox(height: 18),
                    ],

                    AppTextField(
                      controller: model.userIdController,
                      hintText: 'User ID',
                      focusedHintText: 'Enter your User ID',
                      leadingIcon: Icons.alternate_email,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: model.validateUserId,
                    ),

                    AppSpacing.h16,

                    AppTextField(
                      controller: model.passwordController,
                      hintText: 'Password',
                      focusedHintText: 'Enter your password',
                      leadingIcon: Icons.lock_outline,
                      obscureText: model.obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction:
                          model.isSignupMode
                              ? TextInputAction.next
                              : TextInputAction.done,
                      validator: model.validatePassword,
                      trailing: IconButton(
                        onPressed: model.togglePasswordVisibility,
                        icon: Icon(
                          model.obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      onFieldSubmitted: (_) {
                        if (model.isLoginMode) {
                          model.submit();
                        }
                      },
                    ),

                    if (model.isSignupMode) ...[
                      const SizedBox(height: 18),

                      AppTextField(
                        controller: model.confirmPasswordController,
                        hintText: 'Confirm Password',
                        focusedHintText: 'Re-enter your password',
                        leadingIcon: Icons.lock_outline,
                        obscureText: model.obscureConfirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        validator: model.validateConfirmPassword,
                        trailing: IconButton(
                          onPressed: model.toggleConfirmPasswordVisibility,
                          icon: Icon(
                            model.obscureConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                        onFieldSubmitted: (_) => model.submit(),
                      ),
                    ],

                    AppSpacing.h24,

                    // AppButton(onTap: onTap, title: title),

                    // SizedBox(
                    //   height: 54,
                    //   child: ElevatedButton(
                    //     onPressed: model.isBusy ? null : model.submit,
                    //     style: ElevatedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(16),
                    //       ),
                    //     ),
                    //     child:
                    //         model.isBusy
                    //             ? const SizedBox(
                    //               height: 22,
                    //               width: 22,
                    //               child: CircularProgressIndicator(
                    //                 strokeWidth: 2,
                    //               ),
                    //             )
                    //             : Text(
                    //               model.isSignupMode
                    //                   ? 'Create Account'
                    //                   : 'Sign In',
                    //               style: const TextStyle(
                    //                 fontWeight: FontWeight.w600,
                    //                 fontSize: 16,
                    //               ),
                    //             ),
                    //   ),
                    // ),
                    AppButton(
                      onTap: model.isBusy ? null : model.submit,
                      title: model.isSignupMode ? 'Create Account' : 'Sign In',
                      expanded: true,
                      height: 54,
                      borderRadius: AppConstant.xxxl,
                      isPrimary: true,
                      isLoading: model.isBusy,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSurfaceVariant,
                      borderColor: Theme.of(context).dividerColor,
                      icon:
                          model.isSignupMode
                              ? Icons.person_add_alt_1_outlined
                              : Icons.login,
                    ),
                    AppSpacing.h20,

                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          model.isSignupMode
                              ? 'Already have an account? '
                              : "Don't have an account? ",
                        ),
                        TextButton(
                          onPressed: model.isBusy ? null : model.toggleMode,
                          child: Text(
                            model.isSignupMode ? 'Sign In' : 'Create Account',
                          ),
                        ),
                      ],
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
