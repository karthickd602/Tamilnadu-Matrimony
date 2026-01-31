import 'dart:async';

import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';
import 'package:tamilnadu_matrimony/features/authentication/controller/login/login_controller.dart';
import 'package:tamilnadu_matrimony/utils/popups/full_screen_loader.dart';

import '../../../../utils/constants/path_provider.dart';
import '../../model/login_otp_model.dart';
import '../../screen/otp/sms_retriever_impl.dart';

class OtpController extends GetxController {
  var secondsRemaining = 300.obs;
  late Timer _timer;
  final otpTextController = TextEditingController();
  late final SmsRetriever smsRetriever;
  late final SmartAuth smartAuth;

  final storage = GetStorage();

  final loginController = LoginController.instance;

  // final List<TextEditingController> otpControllers = List.generate(
  //   6,
  //   (_) => TextEditingController(),
  // );

  @override
  void onInit() {
    super.onInit();
    startTimer();
    smartAuth = SmartAuth.instance;
    smsRetriever = SmsRetrieverImpl(smartAuth);
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

      if (otpTextController.text.length < 6) {
        TLoaders.warningSnackBar(
          title: "Empty OTP",
          message: "Please enter the OTP.",
        );
        return;
      }
      TFullScreenLoader.popUpCircular();
      final request = {
        "mobile_no": loginController.mobileNoT.text,
        "otp": otpTextController.text,
      };
      debugPrint("OTP Verify1 : $request");
      final response = await THttpHelper.post(ApiConstant.verifyOtp, request);
      debugPrint("OTP Verify : $response");
      if (response['statusCode'] == 200) {
        storage.write(TTexts.userId, response['user_id'].toString());
        storage.write(TTexts.barerToken, response['token'].toString());
        storage.write(TTexts.appPages, response['app_page']);
        TFullScreenLoader.stopLoading();

        if (storage.read(TTexts.appPages) == 0) {
          Get.offAllNamed(TRoutes.bottomNav);
        } else {
          Get.offAllNamed(TRoutes.register);
        }
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "Failed", message: response['message']);
      }
      // TFullScreenLoader.stopLoading();

      // Get.offAllNamed(TRoutes.register);
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

  // void retryOtp() {}

  Future<void> resendOtp() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }

      TFullScreenLoader.popUpCircular();

      final request = {"mobile_no": loginController.mobileNoT.text};
      //
      final response = await THttpHelper.post(ApiConstant.sendOtp, request);
      loginController.loginOtpModel.value = (response['data'] as List)
          .map((e) => LoginOtpModel.fromJson(e))
          .toList();
      debugPrint(
        "loginApi Response:${loginController.mobileNoT.text} ${response.toString()}",
      );

      secondsRemaining.value = 300;
      startTimer();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Authentication Failed",
        message: e.toString(),
      );
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
