import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import '../profile/controller/profile_controller.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  final storage = GetStorage();
  final profileController = Get.put(ProfileController());

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      validate();
    });
    super.onInit();
  }

  void validate() async {
    if (storage.read(TTexts.userId) != null) {
      if (storage.read(TTexts.appPages) == 0) {
        Get.offAllNamed(TRoutes.bottomNav);
      } else {
        Get.offAllNamed(TRoutes.register);
        // await profileController.fetchUserProfile();
      }
    } else {
      Get.offAllNamed(TRoutes.languageSelection);
    }
    // await storage.write(TTexts.userId, "11623");

    debugPrint("userId: ${storage.read(TTexts.userId)}");
    // Get.offAllNamed(TRoutes.loginPage);

    // Get.offAllNamed(TRoutes.languageSelection);
    // Get.offAllNamed(TRoutes.bottomNav);
  }
}
