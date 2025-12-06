import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import '../../../utils/popups/full_screen_loader.dart';
import '../model/subscription_model.dart';

class SubscriptionController extends GetxController {
  final RxList<SubscriptionPlan> plans = <SubscriptionPlan>[].obs;
  final RxInt selectedIndex = 0.obs;

  // Return nullable to avoid RangeError when plans is empty
  SubscriptionPlan? get selectedPlan =>
      plans.isNotEmpty ? plans[selectedIndex.value] : null;

  // Selected plan index
  var status = "Active".obs;
  var package = "Basic".obs;
  var issueDate = "18 Jul, 2025".obs;
  var expiryDate = "18 Jul, 2026".obs;
  var daysLeft = "260 Days Left".obs;
  @override
  void onInit() async{
    super.onInit();
    // run after first frame to ensure overlay/context is ready
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    await  fetchSubscriptionPlans();
    // });
  }


  Future<void> fetchSubscriptionPlans() async {
    try {

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      TFullScreenLoader.popUpCircular();
      final response = await THttpHelper.get(ApiConstant.subscriptionPlans);
      debugPrint("subscriptionPlans response: $response");
      TFullScreenLoader.stopLoading();

      final data = SubscriptionResponse.fromJson(response);

      plans.assignAll(data.data ?? []);

      // defensive: clamp selectedIndex if out of range
      if (plans.isEmpty) {
        selectedIndex.value = 0;
      } else {
        selectedIndex.value = selectedIndex.value.clamp(0, plans.length - 1);
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      print("Error fetching plans: $e");
    }
  }

  void selectPlan(int index) {
    if (index >= 0 && index < plans.length) {
      selectedIndex.value = index;
    }
  }
}
