import 'package:get/get.dart';

class RegisterController extends GetxController {
  var currentStep = 0.obs;

  // total steps
  final int totalSteps = 4;

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      // Submit logic
      Get.snackbar("Success", "Form Submitted!");
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
}
