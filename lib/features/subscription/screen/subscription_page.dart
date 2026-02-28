import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';

import '../../../utils/constants/image_strings.dart';
import '../controller/subscription_controller.dart';
import 'widget/plan_card.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchSubscriptionPlans();
    });
    return Scaffold(
      appBar: TAppBar(title: "Subscription", isBackButtonNeed: true),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    _buildFeature(
                      Icons.all_inclusive,
                      "Get access to unlimited profiles",
                    ),
                    _buildFeature(
                      Icons.filter_alt_outlined,
                      "Get access to premium filters",
                    ),
                    _buildFeature(Icons.timer, "Package validity for 90 days"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Obx(
                () => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 170, // height of PlanCard
                  ),

                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 3,
                  //   // childAspectRatio: 2,
                  //   crossAxisSpacing: 16,
                  //   mainAxisSpacing: 16,
                  // ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index) {
                    return Obx(() {
                      final plan = controller.plans[index];
                      final selected = controller.selectedIndex.value == index;
                      return GestureDetector(
                        onTap: () => controller.selectPlan(index),
                        child: PlanCard(plan: plan, selected: selected),
                      );
                    });
                  },
                  itemCount: controller.plans.length,
                ),
              ),
              const SizedBox(height: 30),

              // Buy Button (Dynamic)
              Obx(() {
                final selected = controller.selectedPlan;
                final enabled = selected != null;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: enabled ? Colors.red : Colors.grey,
                        side: BorderSide(
                          color: enabled ? Colors.red : Colors.grey,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: enabled
                          ? () => controller.buySubscription(selected)
                          : null,
                      child: Text(
                        enabled
                            ? "Buy package for ₹ ${selected.price}"
                            : "Loading plans...",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
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
}
