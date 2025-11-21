import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../controller/filter_controller.dart';
import '../widget/filter_options.dart';

class FilterPage extends GetView<FilterController> {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = TColors.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TAppBar(title: "Filter", isBackButtonNeed: true,backgroundColor: Colors.white,),
      persistentFooterButtons: [
        _BottomButtons(primaryColor: primaryColor),
      ],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // 🔹 Left Category Menu
                  _LeftCategoryMenu(primaryColor: primaryColor),

                  // 🔹 Right Options Area
                  Expanded(
                    child: Obx(() {
                      final category =
                      controller.filterCategories[controller.selectedIndex.value];
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: FilterOptionsWidget(
                          key: ValueKey(category), // triggers animation
                          category: category,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
        
            // 🔹 Bottom Buttons
            // _BottomButtons(primaryColor: primaryColor),
          ],
        ),
      ),
    );
  }
}

// 🔹 Left Category Menu
class _LeftCategoryMenu extends StatelessWidget {
  final Color primaryColor;

  const _LeftCategoryMenu({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Container(
      width: Get.width * 0.35,
      color: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: controller.filterCategories.length,
        itemBuilder: (context, index) {
          final category = controller.filterCategories[index];
          return Obx(() {
            final isSelected = controller.selectedIndex.value == index;
            final isLocked = controller.isLocked(category);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : [],
              ),
              child: ListTile(
                onTap: isLocked ? null : () => controller.changeCategory(index),
                title: Text(
                  category,
                  style: TextStyle(
                    color: isLocked
                        ? Colors.grey
                        : isSelected
                        ? primaryColor
                        : Colors.black87,
                    fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                trailing: isLocked
                    ? const Icon(Icons.lock, color: Colors.grey, size: 18)
                    : null,
              ),
            );
          });
        },
      ),
    );
  }
}

// 🔹 Bottom Buttons
class _BottomButtons extends StatelessWidget {
  final Color primaryColor;

  const _BottomButtons({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: controller.resetFilters,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Reset"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => Get.back(result: controller.selectedOptions),
            icon: const Icon(Icons.check_rounded),
            label: const Text("Apply"),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
