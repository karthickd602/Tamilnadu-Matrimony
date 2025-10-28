import 'package:flutter/material.dart';

class TDropdownField<T> extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final List<T> items;
  final T? selectedValue;
  final String Function(T) itemAsString;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isExpanded;

  const TDropdownField({
    super.key,
    required this.label,
    this.prefixIcon,
    required this.items,
    required this.itemAsString,
    this.selectedValue,
    this.onChanged,
    this.validator,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: isExpanded,
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(itemAsString(item)),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
