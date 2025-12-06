import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

import '../../../../../common/widgets/dropdown/dropdown_with_search.dart';
import '../../../../../utils/constants/path_provider.dart';
import '../../../controller/register/register_controller.dart';
import '../widgets/get_image.dart';

class HoroscopeDetails extends StatelessWidget {
  const HoroscopeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegistrationController.instance;
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: controller.horoscopeFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.horoscopeDetails.tr,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TSearchDropdownField<String>(
                label: "ராசி",
                items: controller.raasiList,
                selectedItem: controller.selectedRaasi.value,
                onChanged: controller.onRaasiChanged,
                prefixIcon: Icons.star_border,
                validator: (v) =>
                    v == null ? "தயவுசெய்து ராசி தேர்ந்தெடுக்கவும்" : null,
              ),
              const SizedBox(height: TSizes.md),

              /// STAR depends on RASSI
              TSearchDropdownField<String>(
                label: "நட்சத்திரம்",
                items: controller.starsForSelectedRaasi,
                selectedItem: controller.selectedStar.value,
                onChanged: controller.onStarChanged,
                prefixIcon: Icons.auto_awesome,
                validator: (v) => controller.selectedRaasi.value == null
                    ? "தயவுசெய்து நட்சத்திரம் தேர்ந்தெடுக்கவும்"
                    : null,
              ),
              const SizedBox(height: TSizes.md),

              /// DASA depends on STAR
              TSearchDropdownField<String>(
                label: "திசை (Dasa Type)",
                items: controller.filteredDasaList,
                selectedItem: controller.selectedDasa.value,
                onChanged: (v) => controller.selectedDasa.value = v,
                prefixIcon: Icons.sunny,
              ),
              const SizedBox(height: TSizes.md),
       TSearchDropdownField<String>(
                label: TTexts.isDoshamHave.tr,
                items: [TTexts.yes.tr, TTexts.no.tr, TTexts.iDontKnow.tr],
                selectedItem: controller.areYouHaveDhosam.value,
                onChanged: (v) => controller.isDoshamHave.value = v??'',
                prefixIcon: Icons.warning_amber_rounded,
         validator: (value) =>
             TValidator.validateEmptyText(TTexts.isDoshamHave.tr, value),
              ),


              SizedBox(height: TSizes.md),
              // const SizedBox(height: TSizes.spaceBtwInputFields),
              /// --- Dosham Dropdown ---
              controller.isDoshamHave.value == TTexts.yes.tr
                  ? TSearchDropdownField<String>(
                      label: "தோஷம் (Dhosam)",
                      items: controller.filteredDhosamList,
                      selectedItem: controller.selectedDhosam.value,
                      onChanged: (v) => controller.selectedDhosam.value = v,
                      prefixIcon: Icons.warning_amber,
                    )
                  : const SizedBox(),
              SizedBox(height: TSizes.md),

              /// --- Upload Horoscope Image ---
              ImagePickerBox(
                title: TTexts.uploadHoroscopeImage.tr,
                onPickImage: () {
             controller.selectHoroscopeImage(context);
                },
                imagePath: controller.horoscopeImagePath,
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
      ),
    );
    // );
  }
}
