import 'dart:io';

import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

import '../../../../../utils/constants/path_provider.dart';
import '../../../controller/register/register_controller.dart';
import '../widgets/get_image.dart';

class HoroscopeDetails extends StatelessWidget {
  const HoroscopeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegistrationController.instance;
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = TColors.primary;

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
              items: [
                "மேஷம்",
                "ரிஷபம்",
                "மிதுனம்",
                "கடகம்",
                "சிம்மம்",
                "கன்னி",
                "துலாம்",
                "விருச்சிகம்",
                "தனுசு",
                "மகரம்",
                "கும்பம்",
                "மீனம்",
              ],
              isDropdown: true,
              onChanged: (v)=>controller.rasiController.value =v??'',

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
              isDropdown: true,
              items: [
                "மேஷம்",
                "ரிஷபம்",
                "மிதுனம்",
                "கடகம்",
                "சிம்மம்",
                "கன்னி",
                "துலாம்",
                "விருச்சிகம்",
                "தனுசு",
                "மகரம்",
                "கும்பம்",
                "மீனம்",
              ],
              onChanged: (v)=>controller.laknamController.value =v??'',
              validator: (value) =>
                  TValidator.validateEmptyText(TTexts.laknam.tr, value),
              labelText: TTexts.laknam.tr,
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




            /// --- Upload Horoscope Image ---
            // Text(
            //   TTexts.uploadHoroscopeImage.tr,
            //   style: textTheme.titleMedium?.copyWith(
            //     fontWeight: FontWeight.w600,
            //     color: primaryColor,
            //   ),
            // ),

            ImagePickerBox(
              title: TTexts.uploadHoroscopeImage.tr,
              onPickImage:()=>controller.showImageSourceSheet(imagePath: controller.horoscopeImagePath), imagePath: controller.horoscopeImagePath,),


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
