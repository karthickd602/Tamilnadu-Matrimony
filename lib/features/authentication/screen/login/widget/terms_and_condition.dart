import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/login/login_controller.dart';



class TTermsAndConditionCheckBox extends StatelessWidget {
  const TTermsAndConditionCheckBox({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller =  LoginController.instance;

    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(width: 24,height: 24,
          child: Obx(
            ()=> Checkbox(value: controller.privacyPolicyCheck.value, onChanged: (value){
              controller.privacyPolicyCheck.value= !controller.privacyPolicyCheck.value;
            }),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Flexible(
          child: Text.rich(
              TextSpan(children: [
                TextSpan(text: '${TTexts.iAgreeTo.tr} ',style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: '${TTexts.privacyPolicy.tr} ',style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark? TColors.white:TColors.green,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.green
                )),
                TextSpan(text: '${TTexts.and.tr } ',style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: TTexts.termsOfUse.tr,style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark? TColors.white:TColors.green,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.green
                )),
              ])),
        )
      ],
    );
  }
}
