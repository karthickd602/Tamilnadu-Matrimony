import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tamilnadu_matrimony/routes/routes.dart';

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

    Get.offAllNamed(TRoutes.loginPage);

    // Get.offAllNamed(TRoutes.languageSelection);


  }
}