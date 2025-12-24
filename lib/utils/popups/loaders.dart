import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';

class TLoaders {
  static void customToast({required String message}) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.85),
      colorText: Colors.white,
      margin: const EdgeInsets.all(20),
      borderRadius: 30,
      duration: const Duration(seconds: 3),
    );
  }

  static void successSnackBar({
    required String title,
    message = '',
    int duration = 3,
  }) {
    final context = Get.context;
    if (context == null) return;
    if (Overlay.maybeOf(context) == null) return;

    Get.snackbar(
      title,
      message,
      maxWidth: 600,
      colorText: Colors.white,
      backgroundColor: TColors.green,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color: TColors.white),
    );
  }

  static void warningSnackBar({required String title, message = ''}) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      title,
      message,
      maxWidth: 600,
      colorText: TColors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }

  static void errorSnackBar({String title = 'Oh Snap', message = ''}) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      title,
      message,
      maxWidth: 600,
      colorText: TColors.white,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }
}
