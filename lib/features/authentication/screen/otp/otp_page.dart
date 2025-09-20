import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controller/otp/otp_controller.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final OtpController controller = Get.put(OtpController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(
            top: 124.0,
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
            bottom: TSizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.enterOtp.tr, // translation key
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
        
              /// OTP Fields
              _buildOtpFields(context),
        
              const SizedBox(height: TSizes.sm),
              Text(TTexts.autoFetching.tr),
        
              Obx(() => controller.secondsRemaining.value > 0
                  ? SizedBox(height: TSizes.spaceBtwSections)
                  : const SizedBox()),
        
              /// Retry Section
              Center(child: _buildRetrySection()),
        
              const Spacer(),
        
              /// Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()=>controller.otpSubmit(),
                  child: Text(TTexts.tContinue.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpFields(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 45,
          child: TextFormField(
            controller: controller.otpControllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildRetrySection() {
    return Obx(() {
      if (controller.secondsRemaining.value > 0) {
        return Text(
          '${TTexts.didNotReceive.tr}\n${TTexts.retryIn.tr} ${controller.secondsRemaining.value}',
          textAlign: TextAlign.center,
        );
      } else {
        return TextButton(
          onPressed: controller.retryOtp,
          child: Text(TTexts.resend.tr),
        );
      }
    });
  }


}
