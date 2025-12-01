
import '../../../utils/constants/path_provider.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../home/model/dashboard_list_model.dart';

class UnlockedController extends GetxController{
  static UnlockedController get instance => Get.find();

  final isLikeLoading = false.obs;
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

      TFullScreenLoader.popUpCircular();
      final req = {"user_id":70952};

      debugPrint("fetchUnlockList req: $req");
      final response = await THttpHelper.post(
        ApiConstant.unlockListEndPoint,
        req,
      );
if(response['statusCode']==204) {
  TFullScreenLoader.stopLoading();
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
    }
  }
}