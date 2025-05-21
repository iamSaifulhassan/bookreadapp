import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/signup/signup_bloc.dart';
import '../../blocs/signup/signup_event.dart';
import '../../blocs/signup/signup_state.dart';
import '../../repositories/user_repository.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';

// This is the new BLoC-based sign-up screen. Use CustomTextField, CustomDropdown, and CustomButton from lib/widgets/ for all input and actions.
// You can use this file as a template for other forms/screens in your app.

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupBloc(UserRepository()),
      child: const SignupForm(),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedCountry;
  String? _userType;

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _setFieldError({String? email, String? password}) {
    setState(() {
      _emailError = email;
      _passwordError = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'assets/images/App.png',
                height: 130,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16.0),
                          CustomTextField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'Enter your email address',
                            icon: Icons.email,
                            validator: (value) {
                              const emailRegex = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!RegExp(emailRegex).hasMatch(value)) {
                                return 'Enter a valid email address';
                              } else if (_emailError != null) {
                                return _emailError;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            hint: 'Enter your phone number',
                            icon: Icons.phone,
                            validator: (value) {
                              const phoneRegex = r'^\+?[0-9]{7,15}$';
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              } else if (!RegExp(phoneRegex).hasMatch(value)) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          CustomDropdown<String>(
                            label: 'Country',
                            value: _selectedCountry,
                            onChanged:
                                (value) =>
                                    setState(() => _selectedCountry = value),
                            items: [
                              ...[
                                // Add your country list here
                                'Pakistan',
                                'India',
                                'United States',
                                'United Kingdom',
                                'Canada',
                                'Australia',
                                'Other',
                              ].map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              ),
                            ],
                            hint: 'Select your country',
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: 'Enter your password',
                            icon: Icons.lock,
                            isObscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              } else if (_passwordError != null) {
                                return _passwordError;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirm Password',
                            hint: 'Re-enter your password',
                            icon: Icons.lock_outline,
                            isObscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password is required';
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomDropdown<String>(
                            label: 'I am a...',
                            value: _userType,
                            onChanged:
                                (value) => setState(() => _userType = value),
                            items: const [
                              DropdownMenuItem(
                                value: 'student',
                                child: Text('Student'),
                              ),
                              DropdownMenuItem(
                                value: 'researcher',
                                child: Text('Researcher'),
                              ),
                              DropdownMenuItem(
                                value: 'other',
                                child: Text('Other'),
                              ),
                            ],
                            hint: 'Select User type',
                          ),
                          const SizedBox(height: 24),
                          BlocConsumer<SignupBloc, SignupState>(
                            listener: (context, state) {
                              if (state is SignupFailure) {
                                if (state.message.contains(
                                  'Email already exists',
                                )) {
                                  _setFieldError(
                                    email: 'Email already exists.',
                                  );
                                  _formKey.currentState!.validate();
                                } else if (state.message.contains(
                                  'valid email',
                                )) {
                                  _setFieldError(email: state.message);
                                  _formKey.currentState!.validate();
                                } else if (state.message.contains('Password')) {
                                  _setFieldError(password: state.message);
                                  _formKey.currentState!.validate();
                                }
                              } else if (state is SignupSuccess) {
                                _setFieldError(email: null, password: null);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Sign-up successful!'),
                                  ),
                                );
                                Navigator.pushNamed(context, '/signin');
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                isLoading: state is SignupLoading,
                                onPressed: () {
                                  _setFieldError(email: null, password: null);
                                  if (_formKey.currentState!.validate() &&
                                      _selectedCountry != null &&
                                      _userType != null) {
                                    context.read<SignupBloc>().add(
                                      SignupSubmitted(
                                        email: _emailController.text.trim(),
                                        phone: _phoneController.text.trim(),
                                        country: _selectedCountry!,
                                        userType: _userType!,
                                        password:
                                            _passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signin');
                              },
                              child: const Text(
                                'Already have an account? Sign In',
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
          ],
        ),
      ),
    );
  }
}

// You can now use CustomTextField, CustomDropdown, and CustomButton in other screens for consistency.
// If you want to refactor other screens (like signin, profile, etc.) to use these widgets, just import them from lib/widgets/.
