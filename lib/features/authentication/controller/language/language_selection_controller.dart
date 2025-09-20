import 'package:get/get.dart';
import 'dart:ui';

class LanguageController extends GetxController {
  var selectedLang = "en".obs; // default Tamil

  void changeLanguage(String langCode) {
    selectedLang.value = langCode;

    if (langCode == "en") {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('ta', 'IN'));
    }
  }
}
