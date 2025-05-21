import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

// Example ProfileScreen using reusable widgets. Replace hardcoded values with BLoC/user state as needed.
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _emailController = TextEditingController(text: 'john.doe@email.com');
  final _phoneController = TextEditingController(text: '+1234567890');
  final _countryController = TextEditingController(text: 'Pakistan');
  final _userTypeController = TextEditingController(text: 'Student');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
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
                  Center(
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: colorScheme.primary.withOpacity(0.1),
                      child: const Icon(
                        Icons.person,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                    icon: Icons.email,
                    validator: (_) => null,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _phoneController,
                    label: 'Phone',
                    hint: 'Enter your phone',
                    icon: Icons.phone,
                    validator: (_) => null,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _countryController,
                    label: 'Country',
                    hint: 'Enter your country',
                    icon: Icons.flag,
                    validator: (_) => null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _userTypeController,
                    label: 'User Type',
                    hint: 'Enter user type',
                    icon: Icons.person_outline,
                    validator: (_) => null,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    onPressed: () {
                      // TODO: Implement edit profile logic with BLoC
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edit Profile coming soon!'),
                        ),
                      );
                    },
                    child: const Text('Edit Profile'),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    onPressed: () {
                      // TODO: Implement sign out logic with BLoC
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sign Out coming soon!')),
                      );
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
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
// - Use BLoC for edit and sign out actions.
// - Add more fields and error handling as needed.
// - Keep UI consistent with other screens using reusable widgets.
// - Remove TODOs as you implement logic.
