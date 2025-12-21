import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

class SplashController extends GetxController{
  static SplashController get to => Get.find();


  final storage = GetStorage();

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      validate();
    });
    super.onInit();
  }

  void validate() async {
await storage.write(TTexts.userId,"11623");

debugPrint("userId: ${storage.read(TTexts.userId)}");
    Get.offAllNamed(TRoutes.loginPage);

    // Get.offAllNamed(TRoutes.languageSelection);
    // Get.offAllNamed(TRoutes.bottomNav);


  }
}