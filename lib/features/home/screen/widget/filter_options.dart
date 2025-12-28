import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/common/widgets/containers/rounded_container.dart';

import '../../controller/filter_controller.dart';

class FilterOptionsWidget extends StatelessWidget {
  final String category;

  const FilterOptionsWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    if (category == "Age") return const _AgeRangeSelector();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Obx(() {
        final options = _getOptions(category, controller);

        if (options.isEmpty) {
          return const Center(child: Text("No options available"));
        }

        final isRadio = _isRadioCategory(category);

        return ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            return isRadio
                ? _RadioTile(category: category, option: option)
                : _CheckboxTile(category: category, option: option);
          },
        );
      }),
    );
  }

  bool _isRadioCategory(String category) =>
      ["Marriage Type", "No Caste Bar", "Disability"].contains(category);

  List<dynamic> _getOptions(String category, FilterController controller) {
    switch (category) {
      case "Caste":
        return controller.casteList;
      case "Education":
        controller.fetchEducationFilter();
        return controller.educationList;
      case "Location":
        return controller.districtList;
      case "Dosham":
        return controller.dhosamList;
      case "Marriage Type":
        return controller.martialStatusList;
      case "No Caste Bar":
        return [
          {"id": 1, "name": "Yes"},
          {"id": 0, "name": "No"},
        ].obs;
      case "Disability":
        return [
          {"id": 1, "name": "Yes"},
          {"id": 0, "name": "No"},
        ].obs;
      default:
        return [];
    }
  }
}

class _CheckboxTile extends StatelessWidget {
  final String category;
  final dynamic option;

  const _CheckboxTile({required this.category, required this.option});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    final int id = option is Map ? option["id"] : option.id;
    final String name = option is Map ? option["name"] : option.name;

    return Obx(() {
      final isSelected = controller.isCheckboxSelected(category, id);

      return TRoundedContainer(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(4),
        showBorder: true,
        child: ListTile(
          onTap: () => controller.toggleCheckbox(category, id),
          title: Text(name),
          trailing: Checkbox(
            value: isSelected,
            onChanged: (_) => controller.toggleCheckbox(category, id),
          ),
        ),
      );
    });
  }
}

class _RadioTile extends StatelessWidget {
  final String category;
  final dynamic option;

  const _RadioTile({required this.category, required this.option});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    final int id = option is Map ? option["id"] : option.id;
    final String name = option is Map ? option["name"] : option.name;

    return Obx(() {
      return TRoundedContainer(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(4),
        showBorder: true,
        child: ListTile(
          onTap: () => controller.selectRadio(category, id),
          title: Text(name),
          trailing: Radio<int>(
            value: id,
            groupValue: controller.selectedOptions[category],
            onChanged: (_) => controller.selectRadio(category, id),
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
