
import 'dart:async';

import '../../../../utils/constants/path_provider.dart';

class OtpController extends GetxController {
  var secondsRemaining = 30.obs;
  late Timer _timer;
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());

  @override
  void onInit() {
    super.onInit();
    startTimer();
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

  void otpSubmit() {
    final otp = otpControllers.map((c) => c.text).join().trim();
    // if (otp.length == 6) {
     TLoaders.successSnackBar(message:TTexts.otpEntered.tr, title: otp);

     Get.offAllNamed(TRoutes.register);
      // Get.offAllNamed(TRoutes.bottomNav);
    // } else {
    //   Get.snackbar(TTexts.errorFullOtp.tr, '');
    // }
  }

  void retryOtp() {
    secondsRemaining.value = 30;
    startTimer();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
