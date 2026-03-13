import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../controller/filter_controller.dart';
import '../widget/filter_options.dart';
import '../../../subscription/controller/subscription_controller.dart';
import '../../../../utils/popups/loaders.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController(), permanent: true);
    final primaryColor = TColors.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TAppBar(
        title: "Filter",
        isBackButtonNeed: true,
        backgroundColor: Colors.white,
      ),

      persistentFooterButtons: [_BottomButtons(primaryColor: primaryColor)],

      body: SafeArea(
        child: Row(
          children: [
            /// LEFT MENU
            _LeftCategoryMenu(primaryColor: primaryColor),

            /// RIGHT OPTIONS
            Expanded(
              child: Obx(() {
                final category =
                    controller.filterCategories[controller.selectedIndex.value];

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: FilterOptionsWidget(
                    key: ValueKey(category),
                    category: category,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////
/// LEFT CATEGORY LIST
//////////////////////////////////////////////////////////////////////////////

class _LeftCategoryMenu extends StatelessWidget {
  final Color primaryColor;

  const _LeftCategoryMenu({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Container(
      width: Get.width * 0.35,
      color: Colors.grey.shade100,
      child: Obx(() {
        return ListView.builder(
          itemCount: controller.filterCategories.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final category = controller.filterCategories[index];
              final isSelected = controller.selectedIndex.value == index;
              final isLocked = controller.isLocked(category);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == index
                      ? Colors.white
                      : Colors.grey.shade100,
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
                  onTap: () {
                    if (isLocked) {
                      TLoaders.warningSnackBar(
                        title: "Subscription Required",
                        message: "Please subscribe to use the $category filter.",
                      );
                      SubscriptionController.instance
                          .fetchUserSubscriptionPlan(navigate: true);
                    } else {
                      controller.changeCategory(index);
                    }
                  },

                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isLocked
                                ? Colors.grey
                                : isSelected
                                ? primaryColor
                                : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),

                      /// BADGE / COUNT / TICK
                      Obx(() {
                        String? badge;

                        if (category == "Age") {
                          badge = controller.getAgeBadge();
                        } else {
                          badge = controller.getCategoryBadge(category);
                        }

                        if (badge == null) return const SizedBox();

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  trailing: isLocked
                      ? const Icon(Icons.lock, color: Colors.grey, size: 18)
                      : null,
                ),
              );
            });
          },
        );
      }),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////
/// BOTTOM BUTTONS (RESET + APPLY)
//////////////////////////////////////////////////////////////////////////////

class _BottomButtons extends StatelessWidget {
  final Color primaryColor;

  const _BottomButtons({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Row(
      children: [
        /// RESET BUTTON
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              controller.resetFilters();
              Get.back();
            },
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

        /// APPLY BUTTON
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.applyFilter,
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
