import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/signup/signup_bloc.dart';
import '../../blocs/signup/signup_event.dart';
import '../../blocs/signup/signup_state.dart';
import '../../repositories/user_repository.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import '../../l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
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
                            label: l10n.emailLabel,
                            hint: l10n.emailHint,
                            icon: Icons.email,
                            validator: (value) {
                              const emailRegex = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
                              if (value == null || value.isEmpty) {
                                return l10n.emailRequiredError;
                              } else if (!RegExp(emailRegex).hasMatch(value)) {
                                return l10n.invalidEmailError;
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
                            label: l10n.phoneNumberLabel,
                            hint: l10n.phoneNumberHint,
                            icon: Icons.phone,
                            validator: (value) {
                              const phoneRegex = r'^\+?[0-9]{7,15}$';
                              if (value == null || value.isEmpty) {
                                return l10n.phoneRequiredError;
                              } else if (!RegExp(phoneRegex).hasMatch(value)) {
                                return l10n.invalidPhoneError;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          CustomDropdown<String>(
                            label: l10n.countryLabel,
                            value: _selectedCountry,
                            onChanged:
                                (value) =>
                                    setState(() => _selectedCountry = value),
                            items: [
                              ...[
                                l10n.countryPakistan,
                                l10n.countryIndia,
                                l10n.countryUnitedStates,
                                l10n.countryUnitedKingdom,
                                l10n.countryCanada,
                                l10n.countryAustralia,
                                l10n.commonOther,
                              ].map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              ),
                            ],
                            hint: l10n.selectCountryHint,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _passwordController,
                            label: l10n.passwordLabel,
                            hint: l10n.passwordHint,
                            icon: Icons.lock,
                            isObscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.passwordRequiredError;
                              } else if (value.length < 6) {
                                return l10n.passwordTooShortError;
                              } else if (_passwordError != null) {
                                return _passwordError;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            label: l10n.confirmPasswordLabel,
                            hint: l10n.confirmPasswordHint,
                            icon: Icons.lock_outline,
                            isObscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.confirmPasswordRequiredError;
                              } else if (value != _passwordController.text) {
                                return l10n.passwordsDoNotMatchError;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomDropdown<String>(
                            label: l10n.userTypeLabel,
                            value: _userType,
                            onChanged:
                                (value) => setState(() => _userType = value),
                            items: [
                              DropdownMenuItem(
                                value: 'Student',
                                child: Text(l10n.userTypeStudent),
                              ),
                              DropdownMenuItem(
                                value: 'Teacher',
                                child: Text(l10n.userTypeTeacher),
                              ),
                              DropdownMenuItem(
                                value: 'Professional',
                                child: Text(l10n.userTypeProfessional),
                              ),
                              DropdownMenuItem(
                                value: 'Researcher',
                                child: Text(l10n.userTypeResearcher),
                              ),
                              DropdownMenuItem(
                                value: 'Other',
                                child: Text(l10n.commonOther),
                              ),
                            ],
                            hint: l10n.selectUserTypeHint,
                          ),
                          const SizedBox(height: 24),
                          BlocConsumer<SignupBloc, SignupState>(
                            listener: (context, state) {
                              if (state is SignupFailure) {
                                if (state.errorCode == 'email-already-in-use') {
                                  _setFieldError(
                                    email: l10n.emailAlreadyExistsFieldError,
                                  );
                                  _formKey.currentState!.validate();
                                } else if (state.errorCode == 'invalid-email') {
                                  _setFieldError(email: state.message);
                                  _formKey.currentState!.validate();
                                } else if (state.errorCode == 'weak-password') {
                                  _setFieldError(password: state.message);
                                  _formKey.currentState!.validate();
                                }
                              } else if (state is SignupSuccess) {
                                _setFieldError(email: null, password: null);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(l10n.signUpSuccessMessage),
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
                                child: Text(
                                  l10n.signUpButton,
                                  style: const TextStyle(fontSize: 16),
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
                              child: Text(
                                l10n.alreadyHaveAccountSignInPrompt,
                                style: const TextStyle(
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
