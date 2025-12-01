import 'dart:convert';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';
import '../model/subscription_model.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/constants/api_constants.dart';

class SubscriptionController extends GetxController {
  RxList<SubscriptionPlan> plans = <SubscriptionPlan>[].obs;
  RxInt selectedIndex = 0.obs;

  SubscriptionPlan get selectedPlan => plans[selectedIndex.value];

  @override
  void onInit() {
    fetchSubscriptionPlans();
    super.onInit();
  }

  Future<void> fetchSubscriptionPlans() async {
    try {
      TFullScreenLoader.popUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final response = await THttpHelper.get(
        ApiConstant.subscriptionPlans,
      );

      TFullScreenLoader.stopLoading();

      final data = SubscriptionResponse.fromJson(response);

      plans.assignAll(data.data ?? []);
        } catch (e) {
      TFullScreenLoader.stopLoading();
      print("Error fetching plans: $e");
    }
  }

  void selectPlan(int index) {
    selectedIndex.value = index;
  }
}
