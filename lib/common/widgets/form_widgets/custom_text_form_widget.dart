import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class TFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? hintText;
  final bool isDropdown;
  final List<String>? items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final String? value; // ✅ Added

  const TFormField({
    super.key,
    required this.labelText,
    this.controller,
    this.hintText,
    this.isDropdown = false,
    this.items,
    this.onChanged,
    this.validator,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isReadOnly = false,
    this.value, // ✅ Added
  });

  @override
  Widget build(BuildContext context) {
    final primary = TColors.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isDropdown
          ? DropdownButtonFormField<String>(
        value: value, // ✅ Default selected value
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: primary),
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        hint: Text(
          hintText ?? labelText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onChanged: onChanged,
        validator: validator,
        items: items
            ?.map(
              (e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ),
        )
            .toList(),
      )
          : TextFormField(
        readOnly: isReadOnly,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          prefixIcon: Icon(icon, color: primary),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
