import 'package:get/get.dart';

class SubscriptionPlan {
  final String name;
  final int unlocks;
  final int price;
  final int originalPrice;

  SubscriptionPlan({
    required this.name,
    required this.unlocks,
    required this.price,
    required this.originalPrice,
  });
}

class SubscriptionController extends GetxController {
  // Available plans
  final plans = <SubscriptionPlan>[
    SubscriptionPlan(name: "Bronze", unlocks: 4, price: 199, originalPrice: 199),
    SubscriptionPlan(name: "Silver", unlocks: 10, price: 399, originalPrice: 399),
    SubscriptionPlan(name: "Gold", unlocks: 35, price: 999, originalPrice: 999),
  ].obs;

  // Selected plan index
  var selectedIndex = 0.obs;

  void selectPlan(int index) {
    selectedIndex.value = index;
  }

  SubscriptionPlan get selectedPlan => plans[selectedIndex.value];
}
