import 'dart:async';

import 'package:tamilnadu_matrimony/features/authentication/controller/login/login_controller.dart';
import 'package:tamilnadu_matrimony/utils/constants/api_constants.dart';
import 'package:tamilnadu_matrimony/utils/http/http_client.dart';
import 'package:tamilnadu_matrimony/utils/popups/full_screen_loader.dart';

import '../../../../utils/constants/path_provider.dart';

class OtpController extends GetxController {
  var secondsRemaining = 300.obs;
  late Timer _timer;
  final otpTextController = TextEditingController();

  // final List<TextEditingController> otpControllers = List.generate(
  //   6,
  //   (_) => TextEditingController(),
  // );

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  Future<void> verifyOtpApi() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      TFullScreenLoader.popUpCircular();


      final loginController = LoginController.instance;
      final request = {
        "mobile_no":loginController.mobileNoT.text,
        "otp":otpTextController.text,

      };
      debugPrint("OTP Verify1 : $request");
      // final response = await THttpHelper.post(ApiConstant.verifyOtp, request);
      // debugPrint("OTP Verify : $response");
      TFullScreenLoader.stopLoading();
      Get.offAllNamed(TRoutes.register);
    } catch (e) {

      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Failed", message: e.toString());
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  /// Format as MM:SS (e.g., 5:00)
  String get formattedTime {
    final minutes = (secondsRemaining.value ~/ 60).toString().padLeft(1, '0');
    final seconds = (secondsRemaining.value % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void retryOtp() {
    secondsRemaining.value = 300;
    startTimer();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
