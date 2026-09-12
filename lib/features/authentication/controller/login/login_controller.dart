import '../../../../utils/constants/path_provider.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../model/login_otp_model.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final privacyPolicyCheck = true.obs;
  final mobileNoT = TextEditingController();

  final loginOtpModel = <LoginOtpModel>[].obs;
  final formKey = GlobalKey<FormState>();

  Future<void> loginApi() async {
    try {
      if (!privacyPolicyCheck.value) {
        TLoaders.customToast(message: "Accept the privacy policy Check");
        return;
      }
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }
      if (!formKey.currentState!.validate()) return;
      TFullScreenLoader.popUpCircular();

      final request = {"mobile_no": mobileNoT.text};
      //
      final response = await THttpHelper.post(ApiConstant.sendOtp, request);


      loginOtpModel.value = (response['data'] as List)
          .map((e) => LoginOtpModel.fromJson(e))
          .toList();


      // GetStorage().read(TTexts.mobileNo,)
      TFullScreenLoader.stopLoading();

      Get.toNamed(TRoutes.otp);
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: "Authentication Failed",
        message: e.toString(),
      );
    } finally {}
  }

  // Future<void> loginApi() async {
  //   Get.toNamed(TRoutes.otp);
  // }
}
