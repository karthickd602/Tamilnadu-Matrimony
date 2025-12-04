import '../../../utils/constants/path_provider.dart';
import '../../home/model/dashboard_list_model.dart';

class LikeController extends GetxController {
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
      isLikeLoading.value = true;
      likeList.clear();

      // TFullScreenLoader.popUpCircular();
      final req = {"user_id": storage.read(TTexts.userId)};

      debugPrint("fetchLikeList req: $req");
      final response = await THttpHelper.post(
        ApiConstant.likeListEndPoint,
        req,
      );
      debugPrint("fetch like list response: $response");
      if(response['statusCode']==204) {
        // TFullScreenLoader.stopLoading();
        return;
      }

      likeList.value = (response["data"] as List)
          .map((e) => CustomerProfileListModel.fromJson(e))
          .toList();
      isLikeLoading.value=false;
      // TFullScreenLoader.stopLoading();
    } catch (e) {
      // TFullScreenLoader.stopLoading();
      debugPrint("fetchLikeList Error: $e");
      TLoaders.errorSnackBar(title: "Error in Like List", message: e.toString());
    }
    finally{
      isLikeLoading.value = false;
    }
  }
}
