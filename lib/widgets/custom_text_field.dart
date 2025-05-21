import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool isObscure;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
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
