import 'package:share_plus/share_plus.dart';
import 'package:tamilnadu_matrimony/data/services/dynamic_link_service.dart';
import 'package:tamilnadu_matrimony/features/alerts/controller/alert_interest_send_controller.dart';
import 'package:tamilnadu_matrimony/features/favorites/controller/unlocked_controller.dart';
import 'package:tamilnadu_matrimony/features/home/model/customer_user_model.dart';
import 'package:tamilnadu_matrimony/features/home/screen/customer_view_page.dart';
import 'package:tamilnadu_matrimony/utils/popups/full_screen_loader.dart';

import '../../../utils/constants/path_provider.dart';
import '../../favorites/controller/like_controller.dart';
import '../model/dashboard_list_model.dart';
import 'filter_controller.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxBool isLikeLoading = false.obs;
  late final String? liked;
  final storage = GetStorage();
  final dashboardCustomerList = <CustomerProfileListModel>[].obs;
  final userModel = CustomerUserModel.empty().obs;
  final RxBool isFirstLoad = false.obs;
  final RxBool isMoreLoading = false.obs;

  final RxInt currentPage = 1.obs;

  // final int pageSize = 10; // If API supports
  final RxBool hasMore = true.obs;
  final searchIdController = TextEditingController();

  /// 🔥 Store applied filters to persist across pagination
  Map<String, dynamic>? _appliedFilters;

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    Get.put(FilterController(), permanent: true);
    fetchDashboardCustomerProfile(isInitial: true);
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!hasMore.value || isMoreLoading.value) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchDashboardCustomerProfile(isInitial: false);
    }
  }

  Future<void> fetchDashboardCustomerProfile({
    bool isInitial = false,
    Map<String, dynamic>? filters,
  }) async {
    try {
      if (isInitial) {
        isFirstLoad.value = true;
        currentPage.value = 1;
        hasMore.value = true;
        dashboardCustomerList.clear();

        /// 🔥 Update stored filters on initial load
        if (filters != null) {
          _appliedFilters = (filters.isEmpty) ? null : filters;
        }
      } else {
        isMoreLoading.value = true;
      }

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isFirstLoad.value = false;
        isMoreLoading.value = false;
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No Internet Connection",
        );
        return;
      }

      /// BASE REQUEST
      final req = {
        "id": storage.read(TTexts.userId),
        "page": currentPage.value,
      };

      if (searchIdController.text.isNotEmpty) {
        req["search_id"] = searchIdController.text.trim();
      }

      /// 🔥 MERGE FILTERS IF PROVIDED OR STORED
      final filtersToUse = filters ?? _appliedFilters;
      if (filtersToUse != null && filtersToUse.isNotEmpty) {
        req.addAll(filtersToUse);
      }

      appDebugPrint("Dashboard Request = $req");

      final response = await THttpHelper.post(
        ApiConstant.dashboardListEndPoint,
        req,
      );

      if (response["statusCode"] == 204) {
        isFirstLoad.value = false;
        isMoreLoading.value = false;
        hasMore.value = false;
        return;
      }

      appDebugPrint("Dashboard Response = $response");

      List newData = response["profiles"] ?? [];

      if (newData.isNotEmpty) {
        dashboardCustomerList.addAll(
          newData.map((e) => CustomerProfileListModel.fromJson(e)).toList(),
        );
        currentPage.value++;
      } else {
        hasMore.value = false;
      }

      isFirstLoad.value = false;
      isMoreLoading.value = false;
    } catch (e) {
      isFirstLoad.value = false;
      isMoreLoading.value = false;
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future<void> fetchCustomerPage(
    int profileId, {
    bool showLoader = true,
  }) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No Internet Connection",
        );
        return;
      }

      if (showLoader) TFullScreenLoader.popUpCircular();
      final req = {
        "user_id": storage.read(TTexts.userId),
        "view_user_id": profileId,
      };
      // final req = {"view_user_id": 11623, "user_id": 11622};

      appDebugPrint("fetchCustomerPage req: $req");
      final response = await THttpHelper.post(
        ApiConstant.customerProfilePage,
        req,
      );

      appDebugPrint("fetchCustomerPage response: $response");
      userModel.value = CustomerUserModel.fromJson(response["data"]);

      if (showLoader) TFullScreenLoader.stopLoading();
    } catch (e) {
      if (showLoader) TFullScreenLoader.stopLoading();
      appDebugPrint("fetchDashboardCustomerProfile Error: $e");
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future<void> likeProfile({
    required int profileId,
    required RxString likedValue,
  }) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No Internet Connection",
        );
        return;
      }

      isLikeLoading.value = true;

      final req = {
        "user_id": storage.read(TTexts.userId),
        "liked_user_id": profileId,
      };
      appDebugPrint("likeProfile req: $req");
      final response = await THttpHelper.post(
        ApiConstant.likeProfileEndPoint,
        req,
      );

      appDebugPrint('likeProfile res $response');

      /// Toggle value for CURRENT MODEL
      likedValue.value = likedValue.value.toLowerCase() == "yes" ? "no" : "yes";

      /// 🔥 Also update the list page (CustomerCard)
      final index = dashboardCustomerList.indexWhere((e) => e.id == profileId);

      if (index != -1) {
        dashboardCustomerList[index].liked.value = likedValue.value;
        dashboardCustomerList.refresh(); // 🔥 force rebuild UI
      }
      await Get.put(LikeController()).fetchLikeList();

      appDebugPrint("likeProfile response: $response");
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Error in Like Profile",
        message: e.toString(),
      );
    } finally {
      isLikeLoading.value = false;
    }
  }

  Future<void> unlockProfile({
    required int profileId,
    required RxString unlockValue,
    bool navigateToView = true,
  }) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No Internet Connection",
        );
        return;
      }

      TFullScreenLoader.popUpCircular();
      final req = {
        "current_user": storage.read(TTexts.userId),
        "target_user": profileId,
      };
      appDebugPrint("unlockProfile req: $req");
      final response = await THttpHelper.post(
        ApiConstant.userUnlockProfileEndPoint,
        req,
      );
      appDebugPrint("unlockProfile response: $response");
      if (response['statusCode'] == 204 || response['statusCode'] == 403) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: "Subscribe to Unlock",
          message: response['message'],
        );

        Get.toNamed(TRoutes.buySubscription);
        return;
      }

      /// Toggle value for CURRENT MODEL

      if (unlockValue.value.toLowerCase() == "true") {
        TFullScreenLoader.stopLoading();

        await fetchCustomerPage(profileId);
        if (navigateToView) {
          Get.to(() => CustomerDetailsView());
        }
        return;
      }
      unlockValue.value = unlockValue.value.toLowerCase() == "true"
          ? "false"
          : "true";

      /// 🔥 Also update the list page (CustomerCard)
      final index = dashboardCustomerList.indexWhere((e) => e.id == profileId);

      if (index != -1) {
        dashboardCustomerList[index].isUnlocked.value = unlockValue.value;
        dashboardCustomerList.refresh(); // 🔥 force rebuild UI
      }
      TFullScreenLoader.stopLoading();
      await fetchCustomerPage(profileId);
      if (navigateToView) {
        Get.to(() => CustomerDetailsView());
      }
      final unlockedController = Get.put(UnlockedController());
      await unlockedController.fetchUnlockList();

      TLoaders.successSnackBar(
        title: "Unlock Success",
        message: response['message'],
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      appDebugPrint("unlockProfile Error: $e");
      TLoaders.errorSnackBar(title: "Unlock Failed", message: e.toString());
    }
  }

  Future<void> sendRequestAPI({required int profileId}) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No Internet Connection",
        );
        return;
      }

      TFullScreenLoader.popUpCircular();
      final req = {
        "sender_id": storage.read(TTexts.userId),
        "receiver_id": profileId,
      };
      final response = await THttpHelper.post(
        ApiConstant.sendInterestProfileEndPoint,
        req,
      );

      appDebugPrint("sendRequestAPI response: $response");
      TLoaders.successSnackBar(
        title: "Send Interest",
        message: response['message'],
      );
      final controller = Get.put(AlertInterestSendController());
      await controller.fetchAlertSendProfile();
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: "Send Interest", message: e.toString());
    }
  }

  Future<void> shareProfile(CustomerUserModel user) async {
    try {
      // Use DynamicLinkService to create a consistent share link
      final String shareLink = DynamicLinkService.instance
          .createProfileShareLink(user.id.toString());

      final shareText =
          '''
🌸 ${TTexts.appName.tr} 🌸

👤 Name: ${user.name ?? '-'}
🎂 Age: ${user.age ?? '-'}
📍 Location: ${user.city ?? '-'}, ${user.state ?? '-'}
🎓 Education: ${user.educationDetails ?? '-'}
💼 Occupation: ${user.occupation ?? '-'}

View full profile here 👇
$shareLink
''';

      await Share.share(shareText, subject: "Matrimony Profile - ${user.name}");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Share Failed", message: e.toString());
    }
  }

  Future<void> shareProfileFromList(CustomerProfileListModel user) async {
    try {
      // Use DynamicLinkService to create a consistent share link
      final String shareLink = DynamicLinkService.instance
          .createProfileShareLink(user.id.toString());

      final shareText =
          '''
🌸 ${TTexts.appName.tr} 🌸

👤 Name: ${user.name ?? '-'}
🎂 Age: ${user.age ?? '-'}
📍 Location: ${user.city ?? '-'}, ${user.state ?? '-'}
🎓 Education: ${user.educationDetails ?? '-'}
💼 Occupation: ${user.occupation ?? '-'}

View full profile here 👇
$shareLink
''';

      await Share.share(shareText, subject: "Matrimony Profile - ${user.name}");
    } catch (e) {
      TLoaders.errorSnackBar(title: "Share Failed", message: e.toString());
    }
  }
}
