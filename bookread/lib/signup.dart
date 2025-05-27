import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedCountry;
  bool _isCheckingEmail = false;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  String? _validatePhone(String? value) {
    const phoneRegex = r'^\+?[0-9]{7,15}$';
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(phoneRegex).hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  // Helper to normalize email for Firebase key (replace . with ,)
  String _emailKey(String email) {
    return email.trim().toLowerCase().replaceAll('.', ',');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final inputFillColor = const Color(0xFFF3F6FA);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Logo
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'assets/images/App.png',
                height: 130,
                fit: BoxFit.contain,
              ),
            ),
            // Scrollable Card
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
                          // Email
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'Enter your email address',
                            icon: Icons.email,
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          // Phone
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            hint: 'Enter your phone number',
                            icon: Icons.phone,
                            validator: _validatePhone,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          // Country
                          DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: 'Search Country',
                                  border: const OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                              menuProps: MenuProps(
                                backgroundColor: Colors.white,
                              ),
                            ),
                            asyncItems: (String filter) async {
                              final countries = [
                                'Afghanistan',
                                'Albania',
                                'Algeria',
                                'Andorra',
                                'Angola',
                                'Argentina',
                                'Armenia',
                                'Australia',
                                'Austria',
                                'Azerbaijan',
                                'Bahamas',
                                'Bahrain',
                                'Bangladesh',
                                'Barbados',
                                'Belarus',
                                'Belgium',
                                'Belize',
                                'Benin',
                                'Bhutan',
                                'Bolivia',
                                'Bosnia and Herzegovina',
                                'Botswana',
                                'Brazil',
                                'Brunei',
                                'Bulgaria',
                                'Burkina Faso',
                                'Burundi',
                                'Cabo Verde',
                                'Cambodia',
                                'Cameroon',
                                'Canada',
                                'Central African Republic',
                                'Chad',
                                'Chile',
                                'China',
                                'Colombia',
                                'Comoros',
                                'Congo',
                                'Costa Rica',
                                'Croatia',
                                'Cuba',
                                'Cyprus',
                                'Czechia',
                                'Denmark',
                                'Djibouti',
                                'Dominica',
                                'Dominican Republic',
                                'Ecuador',
                                'Egypt',
                                'El Salvador',
                                'Equatorial Guinea',
                                'Eritrea',
                                'Estonia',
                                'Eswatini',
                                'Ethiopia',
                                'Fiji',
                                'Finland',
                                'France',
                                'Gabon',
                                'Gambia',
                                'Georgia',
                                'Germany',
                                'Ghana',
                                'Greece',
                                'Grenada',
                                'Guatemala',
                                'Guinea',
                                'Guinea-Bissau',
                                'Guyana',
                                'Haiti',
                                'Honduras',
                                'Hungary',
                                'Iceland',
                                'India',
                                'Indonesia',
                                'Iran',
                                'Iraq',
                                'Ireland',
                                'Israel',
                                'Italy',
                                'Jamaica',
                                'Japan',
                                'Jordan',
                                'Kazakhstan',
                                'Kenya',
                                'Kiribati',
                                'Korea (North)',
                                'Korea (South)',
                                'Kuwait',
                                'Kyrgyzstan',
                                'Laos',
                                'Latvia',
                                'Lebanon',
                                'Lesotho',
                                'Liberia',
                                'Libya',
                                'Liechtenstein',
                                'Lithuania',
                                'Luxembourg',
                                'Madagascar',
                                'Malawi',
                                'Malaysia',
                                'Maldives',
                                'Mali',
                                'Malta',
                                'Marshall Islands',
                                'Mauritania',
                                'Mauritius',
                                'Mexico',
                                'Micronesia',
                                'Moldova',
                                'Monaco',
                                'Mongolia',
                                'Montenegro',
                                'Morocco',
                                'Mozambique',
                                'Myanmar',
                                'Namibia',
                                'Nauru',
                                'Nepal',
                                'Netherlands',
                                'New Zealand',
                                'Nicaragua',
                                'Niger',
                                'Nigeria',
                                'North Macedonia',
                                'Norway',
                                'Oman',
                                'Pakistan',
                                'Palau',
                                'Palestine',
                                'Panama',
                                'Papua New Guinea',
                                'Paraguay',
                                'Peru',
                                'Philippines',
                                'Poland',
                                'Portugal',
                                'Qatar',
                                'Romania',
                                'Russia',
                                'Rwanda',
                                'Saint Kitts and Nevis',
                                'Saint Lucia',
                                'Saint Vincent and the Grenadines',
                                'Samoa',
                                'San Marino',
                                'Sao Tome and Principe',
                                'Saudi Arabia',
                                'Senegal',
                                'Serbia',
                                'Seychelles',
                                'Sierra Leone',
                                'Singapore',
                                'Slovakia',
                                'Slovenia',
                                'Solomon Islands',
                                'Somalia',
                                'South Africa',
                                'South Sudan',
                                'Spain',
                                'Sri Lanka',
                                'Sudan',
                                'Suriname',
                                'Sweden',
                                'Switzerland',
                                'Syria',
                                'Tajikistan',
                                'Tanzania',
                                'Thailand',
                                'Timor-Leste',
                                'Togo',
                                'Tonga',
                                'Trinidad and Tobago',
                                'Tunisia',
                                'Turkey',
                                'Turkmenistan',
                                'Tuvalu',
                                'Uganda',
                                'Ukraine',
                                'United Arab Emirates',
                                'United Kingdom',
                                'United States',
                                'Uruguay',
                                'Uzbekistan',
                                'Vanuatu',
                                'Venezuela',
                                'Vietnam',
                                'Yemen',
                                'Zambia',
                                'Zimbabwe',
                              ];
                              return Future.delayed(
                                const Duration(milliseconds: 200),
                                () =>
                                    countries
                                        .where(
                                          (c) => c.toLowerCase().contains(
                                            filter.toLowerCase(),
                                          ),
                                        )
                                        .toList(),
                              );
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: 'Country',
                                labelStyle: TextStyle(
                                  color: colorScheme.primary.withAlpha(
                                    (0.8 * 255).toInt(),
                                  ),
                                ),
                                hintText: 'Select your country',
                                hintStyle: TextStyle(
                                  color: colorScheme.primary.withAlpha(
                                    (0.5 * 255).toInt(),
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.flag,
                                  color: colorScheme.primary,
                                ),
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: inputFillColor,
                              ),
                              baseStyle: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            dropdownButtonProps: DropdownButtonProps(
                              color: colorScheme.primary,
                            ),
                            dropdownBuilder: (context, selectedItem) {
                              return Text(
                                selectedItem ?? '',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.black87,
                                ),
                              );
                            },
                            onChanged: (value) {
                              setState(() {
                                _selectedCountry = value;
                              });
                            },
                            selectedItem: _selectedCountry,
                          ),
                          const SizedBox(height: 16),
                          // Password
                          _buildTextField(
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
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Confirm Password
                          _buildTextField(
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
                          const SizedBox(height: 24),
                          // Sign Up Button
                          ElevatedButton(
                            onPressed: _isCheckingEmail ? null : _handleSignUp,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child:
                                _isCheckingEmail
                                    ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Text(
                                      'Sign Up',
                                      style: TextStyle(fontSize: 16),
                                    ),
                          ),
                          const SizedBox(height: 16),
                          // Already Sign In
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

  void _handleSignUp() async {
    if (_isCheckingEmail) return;
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isCheckingEmail = true;
      });
      final email = _emailController.text.trim();
      final key = _emailKey(email);
      final dbRef = FirebaseDatabase.instance.ref();
      final userRef = dbRef.child('users').child(key);
      final emailRef = dbRef.child('emails').child(key);
      // Debug: print the key being used
      print('User key: $key');
      // Use a transaction to ensure atomicity
      final result = await emailRef.runTransaction((currentData) {
        if (currentData == null) {
          return Transaction.success(true);
        } else {
          return Transaction.abort();
        }
      });
      setState(() {
        _isCheckingEmail = false;
      });
      if (!result.committed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email already registered!')),
        );
        return;
      }
      await userRef.set({
        'email': email,
        'phone': _phoneController.text.trim(),
        'country': _selectedCountry,
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sign-up successful!')));
      Navigator.pushNamed(context, '/signin');
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool isObscure = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final inputFillColor = const Color(0xFFF3F6FA);

    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      validator: validator,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: colorScheme.primary.withAlpha((0.8 * 255).toInt()),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: colorScheme.primary.withAlpha((0.5 * 255).toInt()),
        ),
        prefixIcon: Icon(icon, color: colorScheme.primary),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: inputFillColor,
      ),
    );
  }
}
