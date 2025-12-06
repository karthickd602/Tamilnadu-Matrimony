import 'package:tamilnadu_matrimony/features/alerts/model/alert_profile_model.dart';

import '../../../utils/constants/path_provider.dart';

class AlertInterestSendController extends GetxController {
  static AlertInterestSendController get instance => Get.find();

  final sendAlertProfileModel = <AlertProfileModel>[].obs;
  final receiveAlertProfileModel = <AlertProfileModel>[].obs;
  final storage = GetStorage();
  final isSendAlertLoading = false.obs;
  final isReceiveAlertLoading = false.obs;

  @override
  void onInit() {
    fetchAlertSendProfile();
    fetchAlertReceiveProfile();
    super.onInit();
  }

  Future<void> fetchAlertSendProfile() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No Internet Connection",
        );
        return;
      }

      isSendAlertLoading.value = true;
      final req = {"user_id": storage.read(TTexts.userId)};
      // final req = {"user_id": "11622"};
      debugPrint("fetchAlertSendProfile req: $req");
      final response = await THttpHelper.post(
        ApiConstant.alertListSendEndPoint,
        req,
      );

      debugPrint("fetchAlertSendProfile response: $response");

      sendAlertProfileModel.value = (response["data"] as List)
          .map((e) => AlertProfileModel.fromJson(e))
          .toList();

    } catch (e) {
      debugPrint("fetchAlertSendProfile Error: $e");
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
    finally{
      isSendAlertLoading.value = false;
    }
  }

  Future<void> fetchAlertReceiveProfile() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No Internet Connection",
        );
        return;
      }

isReceiveAlertLoading.value = true;
      final req = {"user_id": storage.read(TTexts.userId)};
      // final req = {"user_id": "5"};
      debugPrint("fetchAlertReceiveProfile req: $req");
      final response = await THttpHelper.post(
        ApiConstant.alertListReceiveEndPoint,
        req,
      );

      debugPrint("fetchAlertReceiveProfile response: $response");

      receiveAlertProfileModel.value = (response["data"] as List)
          .map((e) => AlertProfileModel.fromJson(e))
          .toList();

    } catch (e) {
      debugPrint("fetchAlertReceiveProfile Error: $e");
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
    finally{
      isReceiveAlertLoading.value = false;
    }
  }
}
