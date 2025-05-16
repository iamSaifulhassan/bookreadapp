import 'package:flutter/material.dart';
import 'Apptheme.dart'; // Import your theme if needed

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    const emailRegex = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/main');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sign-in successful!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final inputFillColor = const Color(0xFFF3F6FA);

    bool _obscurePassword = true;
    bool _rememberMe = false;

    return StatefulBuilder(
      builder:
          (context, setState) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16.0,
                      ), // Reduced margin
                      child: Image.asset(
                        'assets/images/App.png',
                        height: 130,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Form Card
                    Card(
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
                              // Email Field
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: colorScheme.primary.withOpacity(0.8),
                                  ),
                                  border: const OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: colorScheme.primary,
                                  ),
                                  hintText: 'Enter your email address',
                                  hintStyle: TextStyle(
                                    color: colorScheme.primary.withOpacity(0.5),
                                  ),
                                  filled: true,
                                  fillColor: inputFillColor,
                                ),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.black87,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: _validateEmail,
                              ),
                              const SizedBox(height: 16.0),
                              // Password Field with Eye Icon
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: colorScheme.primary.withOpacity(0.8),
                                  ),
                                  border: const OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: colorScheme.primary,
                                  ),
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(
                                    color: colorScheme.primary.withOpacity(0.5),
                                  ),
                                  filled: true,
                                  fillColor: inputFillColor,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: colorScheme.primary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.black87,
                                ),
                                obscureText: _obscurePassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 8.0),
                              // Remember Me Checkbox
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    activeColor: colorScheme.primary,
                                    checkColor: colorScheme.onPrimary,
                                    side: BorderSide(
                                      color:
                                          colorScheme
                                              .primary, // Always show border in theme color
                                      width: 2,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Remember me',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              // Sign In Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _handleSignIn,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    foregroundColor: colorScheme.onPrimary,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              // Sign Up Link
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                    'Don’t have an account? Sign Up',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.primary,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              // Social Login Buttons
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Google Button
                                    GestureDetector(
                                      onTap: () {
                                        // TODO: Implement Google sign-in
                                      },
                                      child: Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                            color:
                                                Colors.transparent, // No border
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Image.asset(
                                              'assets/images/google.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    // Facebook Button
                                    GestureDetector(
                                      onTap: () {
                                        // TODO: Implement Facebook sign-in
                                      },
                                      child: Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                            color:
                                                Colors.transparent, // No border
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Image.asset(
                                              'assets/images/facebook_logo.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
