import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';

import '../../../utils/constants/image_strings.dart';
import '../controller/subscription_controller.dart';
import '../model/subscription_model.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

    return Scaffold(
      appBar: TAppBar(title: "Subscription",isBackButtonNeed: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              TImages.banner1,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),


            const SizedBox(height: 20),

            // Features
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildFeature(Icons.all_inclusive, "Get access to unlimited profiles"),
                  _buildFeature(Icons.filter_alt_outlined, "Get access to premium filters"),
                  _buildFeature(Icons.timer, "Package validity for 90 days"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Plans (Dynamic with Controller)
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(
                  controller.plans.length,
                      (index) {
                    final plan = controller.plans[index];
                    final selected = controller.selectedIndex.value == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectPlan(index),
                        child: _buildPlan(plan, selected),
                      ),
                    );
                  },
                ),
              ),
            )),


            const SizedBox(height: 30),

            // Buy Button (Dynamic)
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.red
                      ,side: BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)

                    ),
                  ),
                  onPressed: () {
                    final selectedPlan = controller.selectedPlan;
                    Get.snackbar("Selected Plan",
                        "${selectedPlan.name} ₹${selectedPlan.price}");
                  },
                  child: Text(
                    "Buy package for ₹ ${controller.selectedPlan.price}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlan(SubscriptionPlan plan, bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? Colors.red : Colors.grey.shade300,
          width: selected ? 2 : 1,
        ),
        color: selected ? Colors.red.withValues(alpha:0.05) : Colors.white,
      ),
      child: Column(
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? Colors.red : Colors.grey,
          ),
          const SizedBox(height: 8),
          Text(
            plan.name.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? Colors.red : Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "${plan.unlocks} unlocks",
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(
            "₹ ${plan.price}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "₹ ${plan.originalPrice}",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
