import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/register/register_controller.dart';
import 'pages/basic_register_page.dart';
import 'pages/contact_detail_register_page.dart';
import 'pages/family_register_page.dart';
import 'pages/horoscope_register_page.dart';


class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());

    final stepTitles = ['Basic Details', 'Family Details', 'Horoscope', 'Contact'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
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
                    return StepBasicDetails();
                  case 1:
                    return FamilyDetails();
                  case 2:
                    return HoroscopeDetails();
                  case 3:
                    return ContactDetailsStep();
                  default:
                    return StepBasicDetails();
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
