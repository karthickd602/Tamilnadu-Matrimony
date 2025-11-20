import 'package:tamilnadu_matrimony/utils/constants/api_constants.dart';
import 'package:tamilnadu_matrimony/utils/http/http_client.dart';
import 'package:tamilnadu_matrimony/utils/popups/full_screen_loader.dart';

import '../../../utils/constants/path_provider.dart';
import '../model/dashboard_list_model.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  var customerList = <Map<String, dynamic>>[].obs;

  final RxBool isLikeLoading = false.obs;
  final dashboardCustomerList = <CustomerProfileListModel>[].obs;
  late final String? liked;


  @override
  void onInit() {
    super.onInit();
    fetchDashboardCustomerProfile();
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
      final req = {"id": TTexts.userId};
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


  Future<void> likeProfile(int profileId) async {
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
      final req = {"user_id": TTexts.userId,"liked_user_id": profileId};
      final response = await THttpHelper.post(
        ApiConstant.likeProfileEndPoint,
        req,
      );

      debugPrint("likeProfile response: $response");

      isLikeLoading.value =false;
    }
    catch (e) {
      isLikeLoading.value =false;
      TLoaders.errorSnackBar(title: "likeProfile", message: e.toString());
    }
  }



}
