import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/filter_controller.dart';

class FilterOptionsWidget extends StatelessWidget {
  final String category;

  const FilterOptionsWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();
    if (category == "Age") {
      return const _AgeRangeSelector(); // 👈 Custom widget for Age
    }

    // Dummy options per category
    final categoryOptions = _getOptionsForCategory(category);

    if (categoryOptions.isEmpty) {
      return const Center(
        child: Text(
          "No options available",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // Determine if this category should use radio (single selection)
    final useRadio = _useRadioForCategory(category);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: categoryOptions.length,
        itemBuilder: (context, index) {
          final option = categoryOptions[index];
          return !useRadio
              ? _RadioOptionTile(
            category: category,
            option: option,
            controller: controller,
          )
              : _CheckboxOptionTile(
            category: category,
            option: option,
            controller: controller,
          );
        },
      ),
    );
  }

  // Example categories that need single selection
  bool _useRadioForCategory(String category) {
    const radioCategories = ["Caste","Education","Location"];
    return radioCategories.contains(category);
  }

  List<String> _getOptionsForCategory(String category) {
    switch (category) {
      case "Caste":
        return ["Brahmin", "Gounder", "Naidu"];
      case "Age":
        return ["18-25", "26-30", "31-35"];
      case "Education":
        return ["BEd", "MEd", "Diploma"];

      case "Marriage Type":
        return ["First Marriage", "Second Marriage"];
      case "Location":
        return ["Madurai", "Ramnad","Trichy"];

      case "Disability":
        return ["Yes", "No"];
      case "No Caste Bar":
        return ["Yes", "No"];
      default:
        return ["Option 1", "Option 2", "Option 3"];
    }
  }
}

// 🔹 Checkbox Tile (multiple selection)
class _CheckboxOptionTile extends StatelessWidget {
  final String category;
  final String option;
  final FilterController controller;

  const _CheckboxOptionTile({
    required this.category,
    required this.option,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.isOptionSelected(category, option);
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () => controller.toggleOption(category, option),
          title: Text(option),
          trailing: Checkbox(
            value: isSelected,
            onChanged: (_) => controller.toggleOption(category, option),
          ),
        ),
      );
    });
  }
}

// 🔹 Radio Tile (single selection)
class _RadioOptionTile extends StatelessWidget {
  final String category;
  final String option;
  final FilterController controller;

  const _RadioOptionTile({
    required this.category,
    required this.option,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedOptions = controller.selectedOptions[category];
      // final isSelected = selectedOptions != null && selectedOptions.contains(option);

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            controller.selectedOptions[category] = [option]; // single selection
          },
          title: Text(option),
          trailing: Radio<String>(
            value: option,
            groupValue: selectedOptions?.first,
            onChanged: (_) {
              controller.selectedOptions[category] = [option];
            },
          ),
        ),
      );
    });
  }
}
class _AgeRangeSelector extends StatelessWidget {
  const _AgeRangeSelector();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Obx(() {
      final ageRange = controller.ageRange.value;

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Age Range",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("From: ${ageRange.start.toInt()}"),
                Text("To: ${ageRange.end.toInt()}"),
              ],
            ),
            RangeSlider(
              min: 18,
              max: 50,
              divisions: 32,
              activeColor: Theme.of(context).primaryColor,
              values: ageRange,
              labels: RangeLabels(
                ageRange.start.toInt().toString(),
                ageRange.end.toInt().toString(),
              ),
              onChanged: (range) => controller.ageRange.value = range,
            ),
          ],
        ),
      );
    });
  }
}
