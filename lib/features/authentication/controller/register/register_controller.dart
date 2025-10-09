import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();

  // Total steps
  final totalSteps = 4;

  // Step index
  RxInt currentStep = 0.obs;

  // Form keys
  final basicFormKey = GlobalKey<FormState>();

  // Basic Details fields
  final nameController = TextEditingController();
  final gender = ''.obs;
  final dob = Rxn<DateTime>();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final maritalStatus = ''.obs;
  final educationController = TextEditingController();
  final occupationController = TextEditingController();
  final incomeController = TextEditingController();
  final religion = ''.obs;
  final caste = ''.obs;
  final subCasteController = TextEditingController();
// Horoscope fields
  final rasiController = TextEditingController();
  final nakshatraController = TextEditingController();
  final gothramController = TextEditingController();
  RxString dosham = ''.obs;
  RxString horoscopeImagePath = ''.obs;

// Pick horoscope image
  Future<void> pickHoroscopeImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      horoscopeImagePath.value = picked.path;
    }
  }

  // Move to next step
  void nextStep() {
    if (basicFormKey.currentState?.validate() ?? false) {
      currentStep.value++;
    }
  }

  // Go back
  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  @override
  void onClose() {
    nameController.dispose();
    heightController.dispose();
    weightController.dispose();
    educationController.dispose();
    occupationController.dispose();
    incomeController.dispose();
    subCasteController.dispose();
    super.onClose();
  }
}
