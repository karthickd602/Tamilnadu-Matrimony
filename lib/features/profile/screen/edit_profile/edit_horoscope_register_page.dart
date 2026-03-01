import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

import '../../../../../utils/constants/path_provider.dart';
import '../../../../common/widgets/dropdown/dropdown_with_search.dart';
import '../../../authentication/screen/register/widgets/get_image.dart';
import '../../controller/edit_profile_controller/edit_profile_controller.dart';

class EditHoroscopeDetails extends StatelessWidget {
  const EditHoroscopeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditProfileController.instance;

    return Form(
      key: controller.horoscopeFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSearchDropdownField<String>(
                label: TTexts.rasi.tr,
                items: controller.raasiList,
                selectedItem: controller.selectedRaasi.value,
                onChanged: controller.onRaasiChanged,
                prefixIcon: Icons.brightness_7_outlined,
                validator: (v) =>
                    TValidator.validateEmptyText(TTexts.rasi.tr, v),
                // v == null ? "தயவுசெய்து ராசி தேர்ந்தெடுக்கவும்" : null,
              ),
              const SizedBox(height: TSizes.md),

              /// STAR depends on RASSI
              TSearchDropdownField<String>(
                label: TTexts.star.tr,
                items: controller.starsForSelectedRaasi,
                selectedItem: controller.selectedStar.value,
                onChanged: controller.onStarChanged,
                prefixIcon: Icons.star_border,
                validator: (v) => controller.selectedStar.value == null
                    ? "தயவுசெய்து நட்சத்திரம் தேர்ந்தெடுக்கவும்"
                    : null,
              ),
              const SizedBox(height: TSizes.md),
              TSearchDropdownField<String>(
                label: TTexts.laknam.tr,
                items: controller.raasiList,
                selectedItem: controller.selectedLaknam.value,
                onChanged: (v) => controller.selectedLaknam.value = v ?? '',
                prefixIcon: Icons.auto_awesome,
                // onChanged: controller.onStarChanged,
                validator: (v) =>
                    TValidator.validateEmptyText(TTexts.laknam.tr, v),
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
                onChanged: controller.onDoshamChanged,
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
                      prefixIcon: Icons.gpp_maybe_outlined,
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
