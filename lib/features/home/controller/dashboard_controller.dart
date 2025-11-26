import 'package:tamilnadu_matrimony/features/home/model/customer_user_model.dart';
import 'package:tamilnadu_matrimony/utils/popups/full_screen_loader.dart';

import '../../../utils/constants/path_provider.dart';
import '../model/dashboard_list_model.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();


  final RxBool isLikeLoading = false.obs;
  late final String? liked;
  final storage = GetStorage();
  final dashboardCustomerList = <CustomerProfileListModel>[].obs;
  final userModel = CustomerUserModel
      .empty()
      .obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardCustomerProfile();
    // fetchCustomerPage();
  }

  Future<void> fetchDashboardCustomerProfile() async {
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
      final req = {"id": storage.read(TTexts.userId)};

      debugPrint("fetchDashboardCustomerProfile req: $req");
      final response = await THttpHelper.post(
        ApiConstant.dashboardListEndPoint,
        req,
      );

      debugPrint("fetchDashboardCustomerProfile response: $response");

      dashboardCustomerList.value = (response["profiles"] as List)
          .map((e) => CustomerProfileListModel.fromJson(e))
          .toList();

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      debugPrint("fetchDashboardCustomerProfile Error: $e");
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
      // final req = {"id": profileId};
      final req = {"id": 11622};

      debugPrint("fetchCustomerPage req: $req");
      final response = await THttpHelper.post(
        ApiConstant.customerProfilePage,
        req,
      );

      debugPrint("fetchDashboardCustomerProfile response: $response");

      final user = (response["data"] as List)
          .map((e) => CustomerUserModel.fromJson(e))
          .toList();
      userModel.value = user.first;

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      debugPrint("fetchDashboardCustomerProfile Error: $e");
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future<void> likeProfile(
      {required CustomerProfileListModel profileModel}) async {
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
        "liked_user_id": profileModel.id
      };
      final response = await THttpHelper.post(
        ApiConstant.likeProfileEndPoint,
        req,
      );
      if (profileModel.liked.value == "yes") {
        profileModel.liked.value = "no";
      } else {
        profileModel.liked.value = "yes";
      }

      debugPrint("likeProfile response: $response");

      isLikeLoading.value = false;
    } catch (e) {
      isLikeLoading.value = false;
      TLoaders.errorSnackBar(
          title: "Error in Like Profile", message: e.toString());
    }
  }
  Future<void> likeProfileInView(
      {required CustomerUserModel profileModel}) async {
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
        "liked_user_id": profileModel.id
      };

      debugPrint("likeProfile response: $req");
      final response = await THttpHelper.post(
        ApiConstant.likeProfileEndPoint,
        req,
      );
      if (profileModel.liked.value == "yes") {
        profileModel.liked.value = "no";
      } else {
        profileModel.liked.value = "yes";
      }

      debugPrint("likeProfile response: $response");

      isLikeLoading.value = false;
    } catch (e) {
      isLikeLoading.value = false;
      TLoaders.errorSnackBar(
          title: "Error in Like Profile", message: e.toString());
    }
  }
}
