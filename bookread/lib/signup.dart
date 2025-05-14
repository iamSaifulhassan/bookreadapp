import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
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

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // Handle sign-up logic here
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sign-up successful!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160.0,
            floating: false,
            pinned: true,
            backgroundColor:
                Colors.transparent, // Make sure the background is transparent
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color:
                    Colors
                        .transparent, // Set to transparent to avoid background color
                child: Image.asset(
                  'assets/images/App.png', // Ensure the image is transparent, if necessary
                  fit: BoxFit.contain,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40.0),
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Enter a valid email address',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 16.0),
                      // Phone Number Field
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                          hintText: 'Enter your phone number',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                      ),
                      const SizedBox(height: 16.0),
                      // Country Dropdown with Search
                      DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              labelText: 'Search Country',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          // Fetch the list of countries from a package or API
                          return Future.delayed(
                            const Duration(milliseconds: 200),
                            () => [
                              'Afghanistan',
                              'Albania',
                              'Algeria',
                              'Andorra',
                              'Angola',
                              'Antigua and Barbuda',
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
                              'Congo (Congo-Brazzaville)',
                              'Costa Rica',
                              'Croatia',
                              'Cuba',
                              'Cyprus',
                              'Czechia (Czech Republic)',
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
                              'Eswatini (fmr. "Swaziland")',
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
                              'Holy See',
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
                              'Myanmar (formerly Burma)',
                              'Namibia',
                              'Nauru',
                              'Nepal',
                              'Netherlands',
                              'New Zealand',
                              'Nicaragua',
                              'Niger',
                              'Nigeria',
                              'North Macedonia (formerly Macedonia)',
                              'Norway',
                              'Oman',
                              'Pakistan',
                              'Palau',
                              'Palestine State',
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
                              'United States of America',
                              'Uruguay',
                              'Uzbekistan',
                              'Vanuatu',
                              'Venezuela',
                              'Vietnam',
                              'Yemen',
                              'Zambia',
                              'Zimbabwe',
                            ],
                          );
                        },
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: 'Country',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountry = value;
                          });
                        },
                        selectedItem: _selectedCountry,
                      ),
                      const SizedBox(height: 16.0),
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Confirm Password Field
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          } else if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // User Type Dropdown
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'I am a...',
                          border: OutlineInputBorder(),
                        ),
                        items: [
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
                        onChanged: (value) {
                          // Handle user type selection
                        },
                      ),
                      const SizedBox(height: 24.0),
                      // Sign Up Button
                      ElevatedButton(
                        onPressed: _handleSignUp,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),

                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Sign In Link
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                          child: Text(
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
            ]),
          ),
        ],
      ),
    );
  }
}
