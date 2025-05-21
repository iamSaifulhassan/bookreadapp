import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final inputFillColor = const Color(0xFFF3F6FA);
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colorScheme.primary.withOpacity(0.8)),
        hintText: hint,
        hintStyle: TextStyle(color: colorScheme.primary.withOpacity(0.5)),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: inputFillColor,
      ),
      iconEnabledColor: colorScheme.primary,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
      items: items,
      onChanged: onChanged,
      value: value,
    );
  }
}
