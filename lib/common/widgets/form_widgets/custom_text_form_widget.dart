import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class TFormField<T> extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? hintText;
  final bool isDropdown;
  final List<T>? items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final T? value;
  final String Function(T)? itemLabelBuilder; // ✅ to get name from model

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
    this.value,
    this.itemLabelBuilder, // ✅
  });

  @override
  Widget build(BuildContext context) {
    final primary = TColors.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isDropdown
          ? DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: primary),
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        hint: Text(
          hintText ?? labelText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onChanged: onChanged,
        validator: validator,
        items: items
            ?.map(
              (e) => DropdownMenuItem<T>(
            value: e,
            child: Text(
              itemLabelBuilder != null
                  ? itemLabelBuilder!(e)
                  : e.toString(),
            ),
          ),
        )
            .toList() ??
            [],
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
        validator: (val) => validator?.call(val as T?),
      ),
    );
  }
}
