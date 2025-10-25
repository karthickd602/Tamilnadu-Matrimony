import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controller/otp/otp_controller.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 124.0,
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
            bottom: TSizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.enterOtp.tr,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              /// OTP Field using Pinput
              _buildPinput(context),

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
                  onPressed: () => controller.verifyOtpApi(),
                  child: Text(TTexts.tContinue.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinput(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: Theme.of(context).textTheme.titleLarge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
    );

    return Center(
      child: Pinput(
        length: 6,
        controller: controller.otpTextController,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          ),
        ),
        onCompleted: (pin) {
          // Automatically submit or save entered OTP
          // for (int i = 0; i < 6; i++) {
          //   controller.otpControllers[i].text = pin[i];
          // }
        },
      ),
    );
  }

  Widget _buildRetrySection() {
    return Obx(() {
      if (controller.secondsRemaining.value > 0) {
        return Text(
          '${TTexts.didNotReceive.tr}\n${TTexts.retryIn.tr} ${controller.formattedTime}',
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
