import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/features/profile/screen/edit_profile/edit_basic_register_page.dart';
import 'package:tamilnadu_matrimony/features/profile/screen/edit_profile/edit_family_register_page.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../controller/edit_profile_controller/edit_profile_controller.dart';
import 'edit_contact_detail_register_page.dart';
import 'edit_horoscope_register_page.dart';


class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    final stepTitles = ['Basic Details', 'Family Details', 'Horoscope', 'Contact'];

    return Scaffold(
      appBar: TAppBar(
        title:'Register',

      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              final idx = controller.currentStep.value;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (idx + 1) / controller.totalSteps,
                            minHeight: 8,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('Step ${idx + 1}/${controller.totalSteps}', style: const TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if(idx < controller.totalSteps - 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(stepTitles[idx], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(onPressed: () {
                          controller.currentStep.value++;
                        },
                        child: Text("Skip",style: Theme.of(context).textTheme.bodyMedium!.copyWith(decoration: TextDecoration.underline),))

                      ],
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 1),
            Expanded(
              child: Obx(() {
                switch (controller.currentStep.value) {
                  case 0:
                    return EditBasicDetails();
                  case 1:
                    return EditFamilyDetails();
                  case 2:
                    return EditHoroscopeDetails();
                  case 3:
                    return EditContactDetails();
                  default:
                    return EditBasicDetails();
                }
              }),
            ),
            // SafeArea(
            //   top: false,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //     child: Obx(() {
            //       return Row(
            //         children: [
            //           if (controller.currentStep.value > 0)
            //             Expanded(
            //               child: OutlinedButton(
            //                 onPressed: controller.previousStep,
            //                 child: const Text('Back'),
            //               ),
            //             )
            //           else
            //             const Spacer(),
            //         //   const SizedBox(width: 12),
            //         //   Expanded(
            //         //     child: ElevatedButton(
            //         //       onPressed: controller.nextStep,
            //         //       child: Text(controller.currentStep.value == controller.totalSteps - 1 ? 'Submit' : 'Next'),
            //         //     ),
            //         //   ),
            //         ],
            //       );
            //     }),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
