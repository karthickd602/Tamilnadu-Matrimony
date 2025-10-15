import 'dart:io';

import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

import '../../../../../utils/constants/path_provider.dart';
import '../../../controller/register/register_controller.dart';

class HoroscopeDetails extends StatelessWidget {
  const HoroscopeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegistrationController.instance;
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = TColors.primary;
    final secondaryColor = Colors.grey[100];

    return Form(
      key: controller.horoscopeFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TTexts.horoscopeDetails.tr,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// --- Rasi ---
            TFormField(
              controller: controller.rasiController,
              validator: (value) =>
                  TValidator.validateEmptyText(TTexts.rasi.tr, value),
              labelText: TTexts.rasi.tr,
              icon: Icons.auto_awesome,
            ),

            /// --- Nakshatra ---
            TFormField(
              controller: controller.nakshatraController,
              labelText: TTexts.nakshatra.tr,
              icon: Icons.star_outline,
            ),
            // const SizedBox(height: TSizes.spaceBtwInputFields),

            /// --- Gothram ---
            TFormField(
              controller: controller.gothramController,
              validator: (value) =>
                  TValidator.validateEmptyText(TTexts.gothram.tr, value),
              labelText: TTexts.gothram.tr,
              icon: Icons.family_restroom_outlined,
            ),
            // const SizedBox(height: TSizes.spaceBtwInputFields),
            /// --- Dosham Dropdown ---
            TFormField(
              labelText: TTexts.dosham.tr,
              validator: (value) =>
                  TValidator.validateEmptyText(TTexts.dosham.tr, value),
              isDropdown: true,
              icon: Icons.warning_amber_rounded,
              items: ["Naga Dosham", "Dosham 2"],
              onChanged: (v) {},
            ),


            GestureDetector(
              onTap: ()=>THelperFunctions.showDatePickerField(controller.dasaBalanceDays,lastDate: DateTime(2100),firstDate: DateTime.now(),initialDate: DateTime.now()),
              child: AbsorbPointer(
                child: TFormField(
                  controller: controller.dasaBalanceDays,
                  labelText: TTexts.dasaBalanceDays.tr,
                  validator: (value) =>
                      TValidator.validateEmptyText(TTexts.dasaBalanceDays.tr, value),
                  icon: Icons.calendar_month,
                ),
              ),
            ),


            /// --- Upload Horoscope Image ---
            Text(
              TTexts.uploadHoroscopeImage.tr,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),

            // const SizedBox(height: TSizes.spaceBtwSections),
            Obx(
              () => GestureDetector(
                onTap: controller.showImageSourceSheet,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: controller.horoscopeImagePath.value.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 42,
                              color: primaryColor,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              TTexts.tapToUpload.tr,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(controller.horoscopeImagePath.value),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.black54,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.close,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  onPressed: () =>
                                      controller.horoscopeImagePath.value = '',
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// --- Continue Button ---
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: controller.horoscopeFormSubmit,
                    child: Text(
                      TTexts.tContinue.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
    // );
  }
}
