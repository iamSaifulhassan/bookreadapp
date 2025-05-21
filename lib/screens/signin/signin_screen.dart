import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/signin/signin_bloc.dart';
import '../../blocs/signin/signin_event.dart';
import '../../blocs/signin/signin_state.dart';
import '../../repositories/user_repository.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

// This is the new SignIn screen, refactored for BLoC and reusable widgets.
// TODO: Integrate BLoC and reusable widgets as needed.
// ...existing code from signin.dart (to be migrated here)...

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return BlocProvider(
      create: (_) => SigninBloc(UserRepository()),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Sign In'),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              color: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'Enter your email',
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'Enter your password',
                      icon: Icons.lock,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
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
                            const SnackBar(
                              content: Text('Sign-in successful!'),
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
                              child: const Text('Sign In'),
                            ),
                            const SizedBox(height: 16),
                            // Google Sign-In Button
                            CustomButton(
                              onPressed: () async {
                                final repo = UserRepository();
                                final success = await repo.signInWithGoogle();
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Google sign-in successful!',
                                      ),
                                    ),
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Google sign-in failed.'),
                                    ),
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google.png',
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Sign in with Google'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Facebook Sign-In Button
                            CustomButton(
                              onPressed: () async {
                                final repo = UserRepository();
                                final success = await repo.signInWithFacebook();
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Facebook sign-in successful!',
                                      ),
                                    ),
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Facebook sign-in failed.'),
                                    ),
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/facebook.png',
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Sign in with Facebook'),
                                ],
                              ),
                            ),
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
                        child: const Text(
                          'Don’t have an account? Sign Up',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 14.0,
                            decoration: TextDecoration.underline,
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

// Guidance:
// - Replace hardcoded controllers with BLoC/user state.
// - Use BLoC for sign in actions.
// - Add error handling and loading state as needed.
// - Keep UI consistent with other screens using reusable widgets.
// - Remove TODOs as you implement logic.
