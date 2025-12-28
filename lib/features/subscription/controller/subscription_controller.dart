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
  var packageName = "".obs;
  var buyDate = "".obs;
  var creditLeft = "".obs;
  var expiryDate = "".obs;
  var daysLeft = "".obs;

  final storage = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    // run after first frame to ensure overlay/context is ready
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    await fetchSubscriptionPlans();
    // });
  }

  Future<void> fetchUserSubscriptionPlan() async {
    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        return;
      }

      TFullScreenLoader.popUpCircular();

      final req = {"user_id": storage.read(TTexts.userId)};
      final response = await THttpHelper.post(
        ApiConstant.getSubscriptionUserPlan,
        req,
      );
      if (response['statusCode'] == 200) {
        packageName.value = response['data']["plan"]['plandisplayname'];
        buyDate.value = THelperFunctions.formatDateString(
          response['data']["order"]['orderdate'],
        );
        creditLeft.value = response['data']["Noofcontacts"].toString();
        expiryDate.value = THelperFunctions.formatDateString(
          response['data']["expiry_date"],
        );

        daysLeft.value =
            "${calculateBalanceDays(DateTime.parse(response['data']["expiry_date"]))} Days Left";
      }

      debugPrint("getSubscriptionUserPlan response: $response");

      TFullScreenLoader.stopLoading();
      if (response['statusCode'] == 200) {
        Get.toNamed(TRoutes.userSubscriptionPlan);
      } else {
        Get.toNamed(TRoutes.buySubscription);
      }

      //
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: "Error in fetching user subscription",
        message: e.toString(),
      );
    } finally {
      // TFullScreenLoader.stopLoading();
    }
  }

  int calculateBalanceDays(DateTime expiryDate) {
    final today = DateTime.now();
    final expiry = DateTime(expiryDate.year, expiryDate.month, expiryDate.day);

    final diff = expiry
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;

    return diff < 0 ? 0 : diff;
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
