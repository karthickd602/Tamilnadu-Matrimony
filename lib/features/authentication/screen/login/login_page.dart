import 'package:tamilnadu_matrimony/features/authentication/controller/login/login_controller.dart';
import 'package:tamilnadu_matrimony/features/authentication/screen/login/widget/terms_and_condition.dart';
import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

import '../../../../utils/constants/path_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      // backgroundColor: TColors.white,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(top: 124.0,bottom: TSizes.defaultSpace,left: TSizes.defaultSpace,right: TSizes.defaultSpace),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // SizedBox(height: 150),
                  Text(
                    TTexts.loginPageHeader.tr,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  Form(
                    key: controller.formKey,
                    child: TextFormField(
                      controller: controller.mobileNoT,
                      validator: (value) =>
                          TValidator.validatePhoneNumber(value),
                      decoration: InputDecoration(
                        labelText: TTexts.mobileNo.tr,
                        counterText: '',
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                  ),
                  SizedBox(height: TSizes.sm),

                  Text(
                    TTexts.loginPageNotifier.tr,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),

              Spacer(),
              Column(
                children: [
                  TTermsAndConditionCheckBox(),
                  SizedBox(height: TSizes.sm),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.loginApi();
                      },
                      child: Text(TTexts.login.tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
