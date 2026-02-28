import '../../../../utils/constants/path_provider.dart';

class LanguageController extends GetxController {
  var selectedLang = "en".obs; // default Tamil
  final storage = GetStorage();
  void changeLanguage(String langCode) {
    selectedLang.value = langCode;
    storage.write(TTexts.languageCode, langCode);
    if (langCode == "en") {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('ta', 'IN'));
    }
  }
}
