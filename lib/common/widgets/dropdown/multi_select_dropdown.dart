// import 'package:multi_dropdown/multi_dropdown.dart';
//
// import '../../utils/helpers/path_provider.dart';
//
// class TMultiDropdown<T extends Object> extends StatelessWidget {
//   final List<DropdownItem<T>> items;
//   final MultiSelectController<T> controller;
//   final String hintText;
//   final Function(List<T>)? onSelectionChange;
//   final String? Function(List<DropdownItem<T>>?)? validator;
//
//   const TMultiDropdown({
//     super.key,
//     required this.items,
//     required this.controller,
//     required this.hintText,
//     this.onSelectionChange,
//     this.validator,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiDropdown<T>(
//       controller: controller,
//       items: items,
//       searchEnabled: true,
//       singleSelect: false,
//
//       fieldDecoration: FieldDecoration(
//         labelText: hintText,
//         labelStyle: const TextStyle().copyWith(
//           fontSize: TSizes.fontSizeMd,
//           color: THelperFunctions.isDarkMode(context)
//               ? TColors.lightGrey
//               : TColors.darkerGrey,
//         ),
//         showClearIcon: false,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.black87),
//         ),
//       ),
//       chipDecoration: ChipDecoration(
//         backgroundColor: Colors.blue.withValues(alpha: 0.2),
//         wrap: false,
//         runSpacing: 2,
//         spacing: 6,
//
//         labelStyle: TextStyle(overflow: TextOverflow.ellipsis),
//       ),
//       dropdownItemDecoration: DropdownItemDecoration(
//         selectedTextColor: THelperFunctions.isDarkMode(context)
//             ? TColors.black
//             : TColors.white,
//         selectedBackgroundColor: THelperFunctions.isDarkMode(context)
//             ? TColors.white
//             : TColors.black,
//       ),
//       onSelectionChange: onSelectionChange,
//       validator: validator,
//
//       dropdownDecoration: DropdownDecoration(
//         backgroundColor: THelperFunctions.isDarkMode(context)
//             ? TColors.black
//             : TColors.white,
//       ),
//     );
//   }
// }
