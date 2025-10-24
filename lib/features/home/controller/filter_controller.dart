import 'package:get/get.dart';

class FilterController extends GetxController {
  // 🔹 Selected category index
  final selectedIndex = 0.obs;

  // 🔹 Categories
  final filterCategories = [
    "Caste",
    "Age",
    "Education",
    "Marriage Type",
    "Nakshatram",
    "Location",
    "Dosham",
    "No Caste Bar",
    "Disability",
  ].obs;

  // 🔹 Locked categories
  final lockedCategories = [ "Dosham","Nakshatram"].obs;

  // 🔹 Selected options per category
  final selectedOptions = <String, List<String>>{}.obs;

  // 🔹 Change active category
  void changeCategory(int index) => selectedIndex.value = index;

  // 🔹 Check if category is locked
  bool isLocked(String category) => lockedCategories.contains(category);

  // 🔹 Toggle option selection
  void toggleOption(String category, String option) {
    final options = selectedOptions[category] ?? [];
    if (options.contains(option)) {
      options.remove(option);
    } else {
      options.add(option);
    }
    selectedOptions[category] = List.from(options); // important for Rx update
  }

  // 🔹 Check if an option is selected
  bool isOptionSelected(String category, String option) {
    return selectedOptions[category]?.contains(option) ?? false;
  }

  // 🔹 Reset all filters
  void resetFilters() => selectedOptions.clear();
}
