import '../../../utils/constants/path_provider.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../home/model/dashboard_list_model.dart';

class UnlockedController extends GetxController {
  static UnlockedController get instance => Get.find();

  final isUnlockLoading = false.obs;
  final storage = GetStorage();
  final unlockList = <CustomerProfileListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUnlockList();
  }

  Future<void> fetchUnlockList() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No Internet Connection",
        );
        return;
      }
      isUnlockLoading.value = true;
      // TFullScreenLoader.popUpCircular();
      final req = {"user_id": 11622};

      debugPrint("fetchUnlockList req: $req");
      final response = await THttpHelper.post(
        ApiConstant.unlockListEndPoint,
        req,
      );
      debugPrint('fetchUnlockList response: $response');
      if (response['statusCode'] == 204) {
        return;
      }
      // if(response)
      debugPrint("fetch like list response: $response");

      unlockList.value = (response["data"] as List)
          .map((e) => CustomerProfileListModel.fromJson(e))
          .toList();

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      debugPrint("fetchUnlockList Error: $e");
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isUnlockLoading.value = false;
    }
  }
}
