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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Top Icon Symbolizing Message/OTP
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.message_rounded,
                  size: 40,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                TTexts.enterOtp.tr,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Phone number & Change Action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "+91 ${controller.loginController.mobileNoT.text}",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.edit_rounded, size: 16, color: theme.primaryColor),
                    label: Text(
                      TTexts.changeNumber.tr,
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              /// OTP Field using Pinput
              _buildPinput(context),

              const SizedBox(height: 24),

              /// Auto fetching indicator
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      TTexts.autoFetching.tr,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              Obx(
                () => controller.secondsRemaining.value > 0
                    ? const SizedBox(height: TSizes.spaceBtwSections)
                    : const SizedBox(),
              ),

              /// Retry Section
              Center(child: _buildRetrySection(theme)),

              const Spacer(),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.verifyOtpApi(),
                  child: Text(TTexts.tContinue.tr),
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinput(BuildContext context) {
    final theme = Theme.of(context);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 64,
      textStyle: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark 
            ? Colors.grey.shade900 
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Center(
      child: Pinput(
        length: 6,
        controller: controller.otpTextController,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark 
                ? theme.primaryColor.withValues(alpha: 0.1)
                : theme.primaryColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.primaryColor, width: 2),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark 
                ? Colors.grey.shade800 
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.primaryColor.withValues(alpha: 0.5), width: 1),
          ),
        ),
        smsRetriever: controller.smsRetriever,
        onCompleted: (pin) {
          controller.verifyOtpApi();
        },
      ),
    );
  }

  Widget _buildRetrySection(ThemeData theme) {
    return Obx(() {
      if (controller.secondsRemaining.value > 0) {
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: theme.textTheme.bodyMedium,
            children: [
              TextSpan(text: '${TTexts.didNotReceive.tr}\n'),
              TextSpan(
                text: '${TTexts.retryIn.tr} ',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: controller.formattedTime,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      } else {
        return TextButton(
          onPressed: controller.resendOtp,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: theme.primaryColor),
            ),
          ),
          child: Text(
            TTexts.resend.tr,
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    });
  }
}
