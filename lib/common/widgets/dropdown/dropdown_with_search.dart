import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../utils/constants/path_provider.dart';

class TSearchDropdownField<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? selectedItem;
  final String Function(T)? itemAsString;
  final bool Function(T, T)? compareFn;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final IconData? prefixIcon; // ✅ Added prefix icon

  const TSearchDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.selectedItem,
    this.itemAsString,
    this.compareFn,
    this.onChanged,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      items: (filter, props) => items,
      selectedItem: selectedItem,
      compareFn: compareFn,
      itemAsString: itemAsString,
      popupProps: PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
        searchFieldProps: TextFieldProps(
          decoration: const InputDecoration(
            hintText: "Search here",
          ),
        ),
        menuProps: MenuProps(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.black
              : TColors.white,
        ),
      ),
      dropdownBuilder: (context, item) {
        final text = item != null
            ? (itemAsString?.call(item) ?? item.toString())
            : '';
        return Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: label,
          labelStyle:Theme.of(context).textTheme.bodyMedium,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color:  TColors.primary)
              : null, // ✅ Added support for prefix icon
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
