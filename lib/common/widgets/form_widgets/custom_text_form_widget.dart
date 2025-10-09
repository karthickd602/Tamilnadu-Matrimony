import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class TFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final bool isDropdown;
  final List<String>? items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final IconData? icon;

  const TFormField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.isDropdown = false,
    this.items,
    this.onChanged,
    this.validator,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final primary = TColors.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 4),
          isDropdown
              ? DropdownButtonFormField<String>(
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            hint: Text(hintText ?? ''),
            onChanged: onChanged,
            validator: validator,
            items: items
                ?.map((e) =>
                DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
          )
              : TextFormField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: primary),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
