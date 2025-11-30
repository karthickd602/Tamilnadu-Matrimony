import '../../../utils/constants/path_provider.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../home/model/dashboard_list_model.dart';

class LikeController extends GetxController{
  static LikeController get instance => Get.find();

  final isLikeLoading = false.obs;
  final storage = GetStorage();
final likeList = <CustomerProfileListModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchLikeList();
  }

  Future<void> fetchLikeList() async {
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
      final req = {"user_id":11623};

      debugPrint("fetchDashboardCustomerProfile req: $req");
      final response = await THttpHelper.post(
        ApiConstant.likeListEndPoint,
        req,
      );

      debugPrint("fetch like list response: $response");

      likeList.value = (response["data"] as List)
          .map((e) => CustomerProfileListModel.fromJson(e))
          .toList();

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      debugPrint("fetchDashboardCustomerProfile Error: $e");
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}