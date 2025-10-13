import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import '../../../../../common/widgets/form_widgets/custom_text_form_widget.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controller/register/register_controller.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegistrationController.instance;
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = TColors.primary;
    final secondaryColor = Colors.grey[100];

    return  Form(
      key: controller.contactFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TTexts.contactDetails.tr,
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// --- Mobile Number ---
            TFormField(
              controller: controller.mobileController,
              labelText: TTexts.mobileNumber.tr,
              icon: Icons.phone_android,
              keyboardType: TextInputType.phone,
            ),


            /// --- WhatsApp Number ---
            TFormField(
              controller: controller.whatsappController,
              labelText: TTexts.whatsappNumber.tr,
              icon: Icons.message,
              keyboardType: TextInputType.phone,
            ),


            /// --- Alternate Mobile ---
            TFormField(
              controller: controller.alternateMobileController,
              labelText: TTexts.alternateMobile.tr,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),


            /// --- Email ---
            TFormField(
              controller: controller.emailController,
              labelText: TTexts.email.tr,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),


            /// --- Address ---
            TFormField(
              controller: controller.addressController,
              labelText: TTexts.address.tr,
              icon: Icons.home_outlined,
              keyboardType: TextInputType.streetAddress,
            ),


            /// --- City ---
            TFormField(
              controller: controller.cityController,
              labelText: TTexts.city.tr,
              icon: Icons.location_city_outlined,
            ),


            /// --- District ---
            TFormField(
              controller: controller.districtController,
              labelText: TTexts.district.tr,
              icon: Icons.map_outlined,
            ),


            /// --- State ---
            TFormField(
              controller: controller.stateController,
              labelText: TTexts.state.tr,
              icon: Icons.flag_outlined,
            ),


            /// --- Pincode ---
            TFormField(
              controller: controller.pincodeController,
              labelText: TTexts.pincode.tr,
              icon: Icons.local_post_office_outlined,
              keyboardType: TextInputType.number,
            ),


        Obx(() => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: controller.noCasteChecked.value,
              onChanged: (newValue){
                controller.noCasteChecked.value = newValue!;
              },
            ),
            const SizedBox(width: TSizes.xs),
            Text(
              TTexts.noCaste.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),),

            const SizedBox(height: 30),

            /// --- Submit Button ---
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.previousStep,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(TTexts.back.tr),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:()=> controller.contactFormSubmit(),
                    icon: const Icon(Icons.check_circle_outline),
                    label: Text(TTexts.submit.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
