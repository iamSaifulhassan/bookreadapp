import 'package:flutter/material.dart';
import '../theme/AppColors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool isObscure;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final inputFillColor =
        readOnly ? Colors.grey.shade100 : const Color(0xFFF3F6FA);

    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      validator: validator,
      readOnly: readOnly,
      style: TextStyle(
        color: readOnly ? AppColors.textSecondary : AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color:
              readOnly
                  ? AppColors.textSecondary
                  : colorScheme.primary.withAlpha((0.8 * 255).toInt()),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color:
              readOnly
                  ? AppColors.textSecondary.withOpacity(0.7)
                  : colorScheme.primary.withAlpha((0.5 * 255).toInt()),
        ),
        prefixIcon: Icon(
          icon,
          color: readOnly ? AppColors.textSecondary : colorScheme.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: readOnly ? Colors.grey.shade300 : colorScheme.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:
                readOnly
                    ? Colors.grey.shade300
                    : colorScheme.primary.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: readOnly ? Colors.grey.shade300 : colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: inputFillColor,
      ),
    );
  }
}
