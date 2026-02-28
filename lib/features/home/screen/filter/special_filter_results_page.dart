import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/common/widgets/loaders/animation_loader.dart';
import 'package:tamilnadu_matrimony/features/home/controller/filter_controller.dart';
import 'package:tamilnadu_matrimony/features/home/screen/widget/customer_card.dart';
import 'package:tamilnadu_matrimony/utils/constants/image_strings.dart';
import 'package:tamilnadu_matrimony/utils/constants/sizes.dart';

class SpecialFilterResultsPage extends StatelessWidget {
  const SpecialFilterResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Scaffold(
      // backgroundColor: TColors.scaffoldColor,
      appBar: const TAppBar(title: "Special Results", isBackButtonNeed: true),
      body: Obx(() {
        if (controller.isSpecialLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.specialFilterProfiles.isEmpty) {
          return Center(
            child: TAnimationLoaderWidget(
              animation: TImages.noDataFoundAnimation,
              text: 'No Data Found',
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ListView.separated(
            itemCount: controller.specialFilterProfiles.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final customer = controller.specialFilterProfiles[index];
              return CustomerCard(customerProfile: customer);
            },
          ),
        );
      }),
    );
  }
}
