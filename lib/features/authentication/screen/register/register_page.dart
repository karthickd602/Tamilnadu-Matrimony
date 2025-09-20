import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/register/register_controller.dart';
import 'pages/basic_register_page.dart';
import 'pages/family_register_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    final pages = [
      const BasicDetailsPage(),
      const FamilyDetailsPage(),
      // const HoroscopeDetailsPage(),
      // const ContactDetailsPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Column(
        children: [
          // 🔹 Step Counter
          Obx(() => Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: List.generate(controller.totalSteps, (index) {
                final isActive = index <= controller.currentStep.value;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }),
            ),
          )),

          // 🔹 Current Page
          Expanded(
            child: Obx(() => pages[controller.currentStep.value]),
          ),

          // 🔹 Navigation Buttons
          Obx(() => Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.nextStep,
                child: Text(
                  controller.currentStep.value == controller.totalSteps - 1
                      ? "Submit"
                      : "Next",
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
