import 'package:flutter/material.dart';
import 'package:one_ai/screen/manual_auth/manual_auth_view_model.dart';
import 'package:one_ai/utility/components/common/animated_ai_icon.dart';
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

                    const SizedBox(height: 32),

                    if (model.isSignupMode) ...[
                      TextFormField(
                        controller: model.nameController,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: model.validateName,
                      ),
                      const SizedBox(height: 18),
                    ],

                    TextFormField(
                      controller: model.userIdController,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.username],
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'User ID',
                        hintText: 'Enter your User ID',
                        prefixIcon: Icon(Icons.alternate_email),
                        border: OutlineInputBorder(),
                      ),
                      validator: model.validateUserId,
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: model.passwordController,
                      obscureText: model.obscurePassword,
                      textInputAction:
                          model.isSignupMode
                              ? TextInputAction.next
                              : TextInputAction.done,
                      autofillHints: [
                        model.isSignupMode
                            ? AutofillHints.newPassword
                            : AutofillHints.password,
                      ],
                      onFieldSubmitted: (_) {
                        if (model.isLoginMode) {
                          model.submit();
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          tooltip:
                              model.obscurePassword
                                  ? 'Show password'
                                  : 'Hide password',
                          onPressed: model.togglePasswordVisibility,
                          icon: Icon(
                            model.obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: model.validatePassword,
                    ),

                    if (model.isSignupMode) ...[
                      const SizedBox(height: 18),

                      TextFormField(
                        controller: model.confirmPasswordController,
                        obscureText: model.obscureConfirmPassword,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.newPassword],
                        onFieldSubmitted: (_) => model.submit(),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Re-enter your password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            tooltip:
                                model.obscureConfirmPassword
                                    ? 'Show password'
                                    : 'Hide password',
                            onPressed: model.toggleConfirmPasswordVisibility,
                            icon: Icon(
                              model.obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        validator: model.validateConfirmPassword,
                      ),
                    ],

                    const SizedBox(height: 28),

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
                    ),

                    const SizedBox(height: 20),

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
