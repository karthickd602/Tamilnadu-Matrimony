import '../../../utils/constants/path_provider.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  final notificationList = <NotificationModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }

  Future<void> getNotificationList() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      isLoading.value = true;
      final res = await THttpHelper.get(ApiConstant.notificationListEndPoint);
      appDebugPrint("Notification List : $res");

      if (res['statusCode'] == 204) {
        return;
      }

      notificationList.value = (res['data'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e))
          .toList();
    } catch (e) {
      appDebugPrint("Notification Error - $e");
      TLoaders.errorSnackBar(
        title: "Notification Error",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
