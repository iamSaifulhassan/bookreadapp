import 'package:bookread/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/signin/signin_bloc.dart';
import '../../blocs/signin/signin_event.dart';
import '../../blocs/signin/signin_state.dart';
import '../../repositories/user_repository.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../l10n/generated/app_localizations.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => SigninBloc(UserRepository()),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(l10n.signInTitle),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/App.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _emailController,
                      label: l10n.emailLabel,
                      hint: l10n.emailHint,
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.emailRequiredError;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      label: l10n.passwordLabel,
                      hint: l10n.passwordHint,
                      icon: Icons.lock,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.passwordRequiredError;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      isObscure: true,
                    ),
                    const SizedBox(height: 32),
                    BlocConsumer<SigninBloc, SigninState>(
                      listener: (context, state) {
                        if (state is SigninFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is SigninSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.viaGoogle
                                    ? l10n.googleSignInSuccessMessage
                                    : l10n.signInSuccessMessage,
                              ),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomButton(
                              isLoading: state is SigninLoading,
                              onPressed: () {
                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty) {
                                  context.read<SigninBloc>().add(
                                    SigninSubmitted(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                              child: Text(l10n.signInButton),
                            ),
                            const SizedBox(height: 16),
                            // Google Sign-In Button
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                              onPressed: () {
                                context.read<SigninBloc>().add(
                                  SigninGoogleSubmitted(),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google.png',
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(l10n.signInWithGoogleButton),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Facebook Sign-In Button
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          l10n.noAccountSignUpPrompt,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
