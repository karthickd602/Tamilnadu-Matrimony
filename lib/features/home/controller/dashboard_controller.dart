import 'package:tamilnadu_matrimony/features/home/model/customer_user_model.dart';
import 'package:tamilnadu_matrimony/utils/popups/full_screen_loader.dart';

import '../../../utils/constants/path_provider.dart';
import '../../favorites/controller/like_controller.dart';
import '../model/dashboard_list_model.dart';

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


  final scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
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
  // Future<void> fetchDashboardCustomerProfile({bool isInitial = false}) async {
  //   try {
  //     if (isInitial) {
  //       isFirstLoad.value = true;
  //       currentPage.value = 1;
  //       hasMore.value = true;
  //       dashboardCustomerList.clear();
  //     } else {
  //       isMoreLoading.value = true;
  //     }
  //
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       TLoaders.errorSnackBar(title: "No Internet", message: "No Internet Connection");
  //       return;
  //     }
  //
  //     final req = {
  //       "id": storage.read(TTexts.userId),
  //       "page": currentPage.value,
  //     };
  //
  //     final response = await THttpHelper.post(
  //       ApiConstant.dashboardListEndPoint,
  //       req,
  //     );
  //
  //     List newData = response["profiles"] ?? [];
  //
  //     if (newData.isNotEmpty) {
  //       dashboardCustomerList.addAll(
  //         newData.map((e) => CustomerProfileListModel.fromJson(e)).toList(),
  //       );
  //
  //       currentPage.value++; // Increment page
  //     } else {
  //       hasMore.value = false; // No more data
  //     }
  //
  //     isFirstLoad.value = false;
  //     isMoreLoading.value = false;
  //
  //   } catch (e) {
  //     isFirstLoad.value = false;
  //     isMoreLoading.value = false;
  //     TLoaders.errorSnackBar(title: "Error", message: e.toString());
  //   }
  // }
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
      } else {
        isMoreLoading.value = true;
      }

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
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

      /// 🔥 MERGE FILTERS IF PROVIDED
      if (filters != null && filters.isNotEmpty) {
        req.addAll(filters);
      }

      debugPrint("Dashboard Request = $req");

      final response = await THttpHelper.post(
        ApiConstant.dashboardListEndPoint,
        req,
      );

      debugPrint("Dashboard Response = $response");


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

  Future<void> fetchCustomerPage(int profileId) async {
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
        "view_user_id": profileId,
        "user_id": storage.read(TTexts.userId),
      };
      // final req = {"id": 11622};

      debugPrint("fetchCustomerPage req: $req");
      final response = await THttpHelper.post(
        ApiConstant.customerProfilePage,
        req,
      );

      debugPrint("fetchCustomerPage response: $response");
      userModel.value = CustomerUserModel.fromJson(response["data"]);

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      debugPrint("fetchDashboardCustomerProfile Error: $e");
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

      final response = await THttpHelper.post(
        ApiConstant.likeProfileEndPoint,
        req,
      );

      /// Toggle value for CURRENT MODEL
      likedValue.value =
      likedValue.value.toLowerCase() == "yes" ? "no" : "yes";

      /// 🔥 Also update the list page (CustomerCard)
      final index = dashboardCustomerList
          .indexWhere((e) => e.id == profileId);

      if (index != -1) {
        dashboardCustomerList[index].liked.value = likedValue.value;
        dashboardCustomerList.refresh();   // 🔥 force rebuild UI
      }
      await Get.put(LikeController()).fetchLikeList();


      debugPrint("likeProfile response: $response");
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Error in Like Profile",
        message: e.toString(),
      );
    } finally {
      isLikeLoading.value = false;
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

      debugPrint("sendRequestAPI response: $response");
      TLoaders.successSnackBar(
        title: "Send Interest",
        message: response['message'],
      );

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: "Send Interest", message: e.toString());
    }
  }
}
