import 'package:flutter/material.dart';
import 'package:one_ai/screen/manual_auth/manual_auth_view_model.dart';
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
                    const SizedBox(height: 24),

                    Icon(
                      model.isSignupMode
                          ? Icons.person_add_alt_1
                          : Icons.lock_outline,
                      size: 52,
                      color: theme.colorScheme.primary,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      model.isSignupMode
                          ? 'Create your account'
                          : 'Welcome back',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      model.isSignupMode
                          ? 'Create an account to get started with OneAI.'
                          : 'Sign in to continue to OneAI.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
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

                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: model.isBusy ? null : model.submit,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child:
                            model.isBusy
                                ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                                : Text(
                                  model.isSignupMode
                                      ? 'Create Account'
                                      : 'Sign In',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                      ),
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
