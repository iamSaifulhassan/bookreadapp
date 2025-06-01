import 'package:flutter/material.dart';
import '../themes/AppColors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String? hint;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.primary.withOpacity(0.8)),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: AppColors.surface,
      ),
      iconEnabledColor: AppColors.primary,
      style: TextStyle(color: AppColors.textPrimary),
      dropdownColor: AppColors.surface,
      items: items,
      onChanged: onChanged,
      value: value,
    );
  }
}
