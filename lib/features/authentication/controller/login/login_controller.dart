

import '../../../../utils/constants/path_provider.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();


  final privacyPolicyCheck = true.obs;
  final mobileNoT = TextEditingController();

  final formKey = GlobalKey<FormState>();



  Future<void> login() async {
    // if (formKey.currentState!.validate()) {
    //   formKey.currentState!.save();
    // }

    Get.toNamed(TRoutes.otp);

  }
}