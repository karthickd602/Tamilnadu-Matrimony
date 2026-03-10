import 'package:app_links/app_links.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/popups/full_screen_loader.dart';
import '../model/subscription_model.dart';

class SubscriptionController extends GetxController
    with WidgetsBindingObserver {
  static SubscriptionController get instance => Get.find();

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
    WidgetsBinding.instance.addObserver(this);
    await fetchUserSubscriptionPlan();
    _initDeepLinkListener();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // User returning from background (or in-app browser close)
      debugPrint("App Resumed: Refreshing Subscription Status...");
      fetchUserSubscriptionPlan();
    }
  }

  void _initDeepLinkListener() {
    final _appLinks = AppLinks();

    // Subscribe to all events (initial link and further)
    _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    debugPrint("Deep link received: $uri");
    if (uri.path.contains('payment')) {
      fetchUserSubscriptionPlan();
    }
  }

  Future<void> fetchUserSubscriptionPlan() async {
    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        return;
      }

      // If we are resumed, we might not want to show full screen loader if already on the page,
      // but let's stick to standard behavior for now or verify context.
      // Use checks if Get.isDialogOpen ?? false

      TFullScreenLoader.popUpCircular();
      // Use silent load or handle loader carefully so we don't stack them if resumed rapidly

      final req = {"user_id": storage.read(TTexts.userId)};
      final response = await THttpHelper.post(
        ApiConstant.getSubscriptionUserPlan,
        req,
      );

      debugPrint("getSubscriptionUserPlan response: $response");

      if (response['statusCode'] == 200) {
        final data = response['data'];

        if (data is Map && data["plan"] != null && data["order"] != null) {
          packageName.value = data["plan"]['plandisplayname'] ?? "";
          buyDate.value = THelperFunctions.formatDateString(
            data["order"]['orderdate'] ?? "",
          );
          creditLeft.value = (data["Noofcontacts"] ?? 0).toString();
          expiryDate.value = THelperFunctions.formatDateString(
            data["expiry_date"] ?? "",
          );

          if (data["expiry_date"] != null) {
            daysLeft.value =
                "${calculateBalanceDays(DateTime.parse(data["expiry_date"]))} Days Left";
          }
          debugPrint("Response structure is Active");

          TFullScreenLoader.stopLoading();
          Get.offNamed(TRoutes.userSubscriptionPlan);
        } else {
          debugPrint("Response structure is not Active");
          await fetchSubscriptionPlans();
          TFullScreenLoader.stopLoading();

          Get.offNamed(TRoutes.buySubscription);
        }
      } else {
        TFullScreenLoader.stopLoading();
        Get.offNamed(TRoutes.buySubscription);
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      // TFullScreenLoader.stopLoading(); // If we removed loader start, remove stop
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
      if (!isConnected) return;

      // TFullScreenLoader.popUpCircular();
      final response = await THttpHelper.get(ApiConstant.subscriptionPlans);
      // TFullScreenLoader.stopLoading();

      final data = SubscriptionResponse.fromJson(response);
      plans.assignAll(data.data ?? []);

      if (plans.isEmpty) {
        selectedIndex.value = 0;
      } else {
        selectedIndex.value = selectedIndex.value.clamp(0, plans.length - 1);
      }
    } catch (e) {
      debugPrint("Error fetching plans: $e");
    }
  }

  void selectPlan(int index) {
    if (index >= 0 && index < plans.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> buySubscription(SubscriptionPlan plan) async {
    try {
      final userId = storage.read(TTexts.userId);
      if (userId == null) {
        TLoaders.errorSnackBar(
          title: "Error",
          message: "User ID not found. Please login again.",
        );
        return;
      }

      final url =
          "https://api.tamilnadumatrimony.net/public/payment/${plan.planId}/$userId";
      // final url = "https://www.jobsintimate.com/payment/${plan.planId}/$userId";
      if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Error",
        message: "Could not open payment page: $e",
      );
    }
  }
}
